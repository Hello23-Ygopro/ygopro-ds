--BT5-104 Death Ball
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,1)
	--extra card
	aux.EnableExtraAttribute(c)
	--gain skill, ko
	aux.AddActivateBattleSkill(c,0,scard.op1,nil,scard.tg1,EFFECT_FLAG_CARD_TARGET,aux.SelfLeaderCondition(Card.IsCharacter,CHARACTER_FRIEZA))
end
--gain skill, ko
function scard.kofilter(c,e)
	return c:IsRest() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	--gain power
	aux.AddTempSkillUpdatePower(e:GetHandler(),Duel.GetLeaderCard(tp),1,15000,RESET_PHASE+PHASE_DAMAGE)
	if Duel.GetTurnPlayer()~=tp then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_KO)
	local g=Duel.SelectMatchingCard(tp,aux.BattleAreaFilter(scard.kofilter),tp,0,LOCATION_BATTLE,0,1,nil,e)
	if g:GetCount()==0 then return end
	Duel.SetTargetCard(g)
	Duel.KO(g,REASON_EFFECT)
end
