--BT1-027 Cabba's Awakening
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--extra card
	aux.EnableExtraAttribute(c)
	--gain skill
	aux.AddActivateBattleSkill(c,0,scard.op1,nil,scard.tg1,EFFECT_FLAG_CARD_TARGET)
end
--gain skill
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.FaceupFilter(Card.IsColor,COLOR_RED),LOCATION_INPLAY,0,0,1,HINTMSG_TARGET)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) then return end
	--gain power
	aux.AddTempSkillUpdatePower(e:GetHandler(),tc,1,6000,RESET_PHASE+PHASE_DAMAGE)
end
