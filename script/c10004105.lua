--BT4-095 Successor of Hope
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--extra card
	aux.EnableExtraAttribute(c)
	--search (to hand)
	aux.AddActivateMainSkill(c,0,scard.op1,nil,scard.tg1,EFFECT_FLAG_CARD_TARGET)
end
--search (to hand)
function scard.thfilter(c)
	return c:IsSpecialTrait(TRAIT_GOKUS_LINEAGE) and c:IsEnergyBelow(5)
		and c:IsHasEffect(EFFECT_SWAP) and c:IsAbleToHand()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.thfilter,LOCATION_DECK,0,0,1,HINTMSG_ATOHAND)
scard.op1=aux.TargetSendtoHandOperation(true)
