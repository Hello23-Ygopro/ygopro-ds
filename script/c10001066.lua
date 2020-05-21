--BT1-057 Broly, The Legendary Super Saiyan
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_BROLY)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_BROLY_SAGA)
	--leader card
	aux.EnableLeaderAttribute(c)
	--attack limit
	aux.AddPermanentCannotSelectBattleTarget(c,scard.val1)
	--draw, drop
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
scard.front_side_code=sid-1
--attack limit
function scard.val1(e,c)
	return c:IsFaceup() and c:IsBattle()
end
--draw, drop
function scard.dropfilter1(c,e)
	return c:IsAbleToDrop() and c:IsCanBeEffectTarget(e)
end
function scard.dropfilter2(c,e)
	return scard.dropfilter1(c,e) and not c:IsLeader()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	Duel.BreakEffect()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DROP)
	local g1=Duel.SelectMatchingCard(tp,aux.HandFilter(scard.dropfilter1),tp,LOCATION_HAND,0,1,1,nil,e)
	if g1:GetCount()>0 then
		Duel.SetTargetCard(g1)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DROP)
	local g2=Duel.SelectMatchingCard(tp,scard.dropfilter2,tp,LOCATION_BATTLE,0,1,1,nil,e)
	if g2:GetCount()>0 then
		Duel.SetTargetCard(g2)
		g1:Merge(g2)
	end
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_DROP)
	local g3=Duel.SelectMatchingCard(1-tp,aux.HandFilter(scard.dropfilter1),1-tp,LOCATION_HAND,0,1,1,nil,e)
	if g3:GetCount()>0 then
		Duel.SetTargetCard(g3)
		g1:Merge(g3)
	end
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_DROP)
	local g4=Duel.SelectMatchingCard(1-tp,scard.dropfilter2,1-tp,LOCATION_BATTLE,0,1,1,nil,e)
	if g4:GetCount()>0 then
		Duel.SetTargetCard(g4)
		g1:Merge(g4)
	end
	Duel.SendtoDrop(g1,REASON_EFFECT)
end
