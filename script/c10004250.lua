--TB2-049 Feet Kamehameha
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,1)
	--extra card
	aux.EnableExtraAttribute(c)
	--gain skill
	aux.AddActivateBattleSkill(c,0,scard.op1,nil,scard.tg1,nil,aux.SelfLeaderCondition(scard.lfilter))
end
--gain skill
function scard.lfilter(c)
	return c:IsColor(COLOR_GREEN) and c:IsCharacter(CHARACTER_SON_GOKU)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetLeaderCard(tp)
	--gain power
	aux.AddTempSkillUpdatePower(c,tc,1,15000,RESET_PHASE+PHASE_DAMAGE)
	--critical
	aux.AddTempSkillCritical(c,tc,2,RESET_PHASE+PHASE_DAMAGE)
end
