--BT1-109 Frieza's Call
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,1)
	--extra card
	aux.EnableExtraAttribute(c)
	--search (play)
	aux.AddActivateMainSkill(c,0,scard.op1,nil,scard.tg1,EFFECT_FLAG_CARD_TARGET)
end
--search (play)
function scard.playfilter(c,e,tp)
	return c:IsSpecialTrait(TRAIT_FRIEZAS_ARMY) and c:IsEnergyBelow(2) and c:IsCanBePlayed(e,0,tp,false,false)
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.playfilter,LOCATION_DECK,0,0,1,HINTMSG_PLAY)
scard.op1=aux.TargetPlayOperation(POS_FACEUP_REST)
