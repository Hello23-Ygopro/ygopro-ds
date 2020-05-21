--BT4-021 Revenge Death Ball
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--extra card
	aux.EnableExtraAttribute(c)
	--gain skill
	aux.AddActivateBattleSkill(c,0,scard.op1,nil,nil,EFFECT_FLAG_CARD_TARGET,aux.SelfLeaderCondition(scard.lfilter))
end
scard.specified_cost={COLOR_RED,1}
--gain skill
function scard.lfilter(c)
	return c:IsColor(COLOR_RED) and c:IsCharacter(CHARACTER_BABY)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	--gain power
	aux.AddTempSkillUpdatePower(c,Duel.GetLeaderCard(tp),1,10000,RESET_PHASE+PHASE_DAMAGE)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectMatchingCard(tp,aux.BattleAreaFilter(Card.IsCanBeEffectTarget),tp,0,LOCATION_BATTLE,0,1,nil,e)
	if g:GetCount()==0 then return end
	Duel.BreakEffect()
	Duel.SetTargetCard(g)
	--lose power
	aux.AddTempSkillUpdatePower(c,g:GetFirst(),2,-15000)
end
