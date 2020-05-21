--BT4-120 Seasoning Arrow
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--extra card
	aux.EnableExtraAttribute(c)
	--gain skill, warp, combo
	aux.AddActivateBattleSkill(c,0,scard.op1,nil,nil,EFFECT_FLAG_CARD_TARGET,aux.SelfLeaderCondition(Card.IsCharacter,CHARACTER_DEMIGRA))
end
--gain skill, warp, combo
function scard.warpfilter(c,e)
	return c:IsAbleToWarp() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	--gain power
	aux.AddTempSkillUpdatePower(c,Duel.GetLeaderCard(tp),1,10000,RESET_PHASE+PHASE_DAMAGE)
	if Duel.GetTurnPlayer()~=tp then return end
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_WARP)
	local g=Duel.SelectMatchingCard(1-tp,aux.HandFilter(scard.warpfilter),1-tp,LOCATION_HAND,0,1,1,nil,e)
	if g:GetCount()==0 then return end
	Duel.BreakEffect()
	Duel.SetTargetCard(g)
	Duel.SendtoWarp(g,REASON_EFFECT)
	local tc=Duel.GetOperatedGroup():GetFirst()
	if not tc:IsBattle() then return end
	Duel.BreakEffect()
	Duel.SendtoCombo(c,tc,tp,REASON_EFFECT)
end
