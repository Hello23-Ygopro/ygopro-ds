--BT3-030 Planet M-2
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_RED,1)
	--extra card
	aux.EnableExtraAttribute(c)
	--field
	aux.EnableField(c)
	--draw
	local e1=aux.AddSingleAutoSkill(c,0,EVENT_CUSTOM+EVENT_MOVE_EXTRA_CARD,nil,scard.op1,nil,scard.con1)
	e1:SetRange(LOCATION_FIELD)
	--gain skill
	aux.AddActivateBattleSkill(c,1,scard.op2,aux.SelfSwitchtoRestCost,scard.tg1,EFFECT_FLAG_CARD_TARGET)
end
--draw
scard.con1=aux.SelfLeaderCondition(Card.IsCharacter,CHARACTER_DR_MYUU)
scard.op1=aux.DuelOperation(Duel.Draw,PLAYER_SELF,1,REASON_EFFECT)
--gain skill
function scard.powfilter(c)
	return c:IsLeader() or c:IsBattle()
end
scard.con2=aux.TurnPlayerCondition(PLAYER_SELF)
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.FaceupFilter(scard.powfilter),0,LOCATION_INPLAY,0,1,HINTMSG_TARGET,scard.con2)
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) then return end
	--lose power
	aux.AddTempSkillUpdatePower(e:GetHandler(),tc,2,-5000,RESET_PHASE+PHASE_DAMAGE)
end
