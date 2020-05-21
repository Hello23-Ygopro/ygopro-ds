--TB1-002 Lady of Destruction Kale
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_KALE)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_ALIEN,TRAIT_UNIVERSE_6)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,TRAIT_CATEGORY_UNIVERSE)
	--leader card
	aux.EnableLeaderAttribute(c)
	--do not drop
	aux.AddPermanentPlayerSkill(c,sid,LOCATION_LEADER,scard.con1,1,0)
	--draw, drop
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.op1)
end
scard.front_side_code=sid-1
--do not drop
scard.con1=aux.ExistingCardCondition(aux.BattleAreaFilter(Card.IsCharacter,CHARACTER_CAULIFLA),LOCATION_BATTLE)
--draw, drop
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local shuffle_hand=false
	if Duel.Draw(tp,1,REASON_EFFECT)>0 then shuffle_hand=true end
	Duel.BreakEffect()
	local g1=Duel.GetMatchingGroup(aux.HandFilter(Card.IsAbleToDrop),tp,LOCATION_HAND,0,nil)
	if g1:GetCount()>0 then
		if shuffle_hand then Duel.ShuffleHand(tp) end
		local min=Duel.IsPlayerAffectedByEffect(tp,sid) and 0 or 1
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DROP)
		local sg=g1:Select(tp,min,1,nil)
		Duel.SendtoDrop(sg,REASON_EFFECT)
	end
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_DROP)
	local g2=Duel.SelectMatchingCard(1-tp,aux.HandFilter(Card.IsAbleToDrop),1-tp,LOCATION_HAND,0,1,1,nil)
	if g2:GetCount()>0 then
		Duel.SendtoDrop(g2,REASON_EFFECT)
	end
end
