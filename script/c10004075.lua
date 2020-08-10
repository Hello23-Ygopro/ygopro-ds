--BT4-068 Special Beam Cannon
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,1)
	--extra card
	aux.EnableExtraAttribute(c)
	--gain skill, drop
	aux.AddActivateBattleSkill(c,0,scard.op1,nil,nil,EFFECT_FLAG_CARD_TARGET,aux.SelfLeaderCondition(Card.IsCharacter,CHARACTER_PICCOLO))
end
--gain skill, drop
function scard.dropfilter(c,e)
	return c:IsAbleToDrop() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	--gain power
	aux.AddTempSkillUpdatePower(e:GetHandler(),Duel.GetLeaderCard(tp),1,10000,RESET_PHASE+PHASE_DAMAGE)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DROP)
	local g=Duel.SelectMatchingCard(tp,aux.HandFilter(scard.dropfilter),tp,0,LOCATION_HAND,0,1,nil,e)
	if g:GetCount()==0 then return end
	Duel.BreakEffect()
	Duel.SetTargetCard(g)
	Duel.SendtoDrop(g,REASON_EFFECT)
end
