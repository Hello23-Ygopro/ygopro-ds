--BT1-052 Objection
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--extra card
	aux.EnableExtraAttribute(c)
	--charge
	aux.AddActivateMainSkill(c,0,scard.op1,nil,scard.tg1,EFFECT_FLAG_CARD_TARGET)
end
scard.specified_cost={COLOR_BLUE,1}
--charge
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.HandFilter(Card.IsAbleToEnergy),LOCATION_HAND,0,0,1,HINTMSG_TOENERGY)
scard.op1=aux.TargetCardsOperation(Duel.SendtoEnergy,POS_FACEUP_ACTIVE,REASON_EFFECT)
