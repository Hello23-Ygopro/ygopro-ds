--BT4-045 The Legendary Flute
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--extra card
	aux.EnableExtraAttribute(c)
	--return, draw
	aux.AddActivateMainSkill(c,0,scard.op1,nil,scard.tg1,EFFECT_FLAG_CARD_TARGET,aux.SelfLeaderCondition(Card.IsColor,COLOR_BLUE))
end
--return, draw
function scard.thfilter(c)
	return c:IsEnergyBelow(3) and c:IsAbleToHand()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(scard.thfilter),LOCATION_BATTLE,LOCATION_BATTLE,0,1,HINTMSG_RTOHAND)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) or Duel.SendtoHand(tc,PLAYER_OWNER,REASON_EFFECT)==0 then return end
	if tc:IsControler(tp) then
		Duel.ShuffleHand(tp)
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
