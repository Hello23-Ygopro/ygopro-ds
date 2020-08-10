--BT5-102 Revival of the Emperor
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,2)
	--extra card
	aux.EnableExtraAttribute(c)
	--add special trait
	aux.AddPermanentAddSpecialTrait(c,TRAIT_DESIRE)
	--play
	aux.AddActivateMainSkill(c,0,scard.op1,nil,scard.tg1,EFFECT_FLAG_CARD_TARGET,aux.SelfLeaderCondition(scard.lfilter))
end
--play
function scard.lfilter(c)
	return c:IsColor(COLOR_YELLOW) and c:IsSpecialTrait(TRAIT_SHENRON)
end
function scard.playfilter(c,e,tp)
	return c:IsCharacter(CHARACTER_FRIEZA) and c:IsEnergyBelow(4) and c:IsCanBePlayed(e,0,tp,false,false)
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.DropAreaFilter(scard.playfilter),LOCATION_DROP,0,1,1,HINTMSG_PLAY)
scard.op1=aux.TargetPlayOperation(POS_FACEUP_ACTIVE)
