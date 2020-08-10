--TB1-078 Coldhearted Strike Frieza
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,2)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_FRIEZA)
	aux.AddSpecialTrait(c,TRAIT_FRIEZA_CLAN,TRAIT_UNIVERSE_7)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,TRAIT_CATEGORY_UNIVERSE)
	--battle card
	aux.EnableBattleAttribute(c)
	--dual attack
	aux.EnableDualAttack(c)
	--drop, tap, gain skill
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,nil,scard.op1,EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_IGNORE_BARRIER)
end
--drop, tap, gain skill
function scard.dropfilter(c)
	return c:IsSpecialTrait(TRAIT_UNIVERSE_7) and c:IsAbleToDrop()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DROP)
	local g1=Duel.SelectMatchingCard(tp,aux.HandFilter(scard.dropfilter),tp,LOCATION_HAND,0,0,1,nil)
	if g1:GetCount()==0 or Duel.SendtoDrop(g1,REASON_EFFECT)==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g2=Duel.SelectMatchingCard(tp,aux.BattleAreaFilter(Card.IsCanBeEffectTarget),tp,0,LOCATION_BATTLE,0,2,nil,e)
	if g2:GetCount()==0 then return end
	Duel.SetTargetCard(g2)
	for tc in aux.Next(g2) do
		Duel.SwitchtoRest(tc,REASON_EFFECT)
		--cannot switch to active
		aux.AddTempSkillCustom(e:GetHandler(),tc,1,EFFECT_CANNOT_CHANGE_POS_E,RESET_PHASE+PHASE_DRAW+RESET_OPPO_TURN,1,aux.SelfRestCondition)
	end
end
