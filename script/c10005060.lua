--BT5-052 Soul Punisher
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--extra card
	aux.EnableExtraAttribute(c)
	--gain skill
	aux.AddActivateBattleSkill(c,0,scard.op1,nil,nil,nil,aux.SelfLeaderCondition(Card.IsCharacter,CHARACTER_GOGETA))
end
scard.specified_cost={COLOR_BLUE,1}
--gain skill
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetLeaderCard(tp)
	--gain power
	aux.AddTempSkillUpdatePower(c,tc,1,15000,RESET_PHASE+PHASE_DAMAGE)
	--critical
	aux.AddTempSkillCritical(c,tc,2,RESET_PHASE+PHASE_DAMAGE)
end
