--BT3-079 To Save a Hopeful Future
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,3)
	--extra card
	aux.EnableExtraAttribute(c)
	--play
	aux.AddActivateMainSkill(c,0,scard.op1,nil,scard.tg1,EFFECT_FLAG_CARD_TARGET)
end
--play
function scard.playfilter(c,e,tp)
	return c:IsBattle() and c:IsColor(COLOR_GREEN) and c:IsEnergyBelow(5) and c:IsCanBePlayed(e,0,tp,false,false)
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.DropAreaFilter(scard.playfilter),LOCATION_DROP,0,0,1,HINTMSG_PLAY)
scard.op1=aux.TargetPlayOperation(POS_FACEUP_ACTIVE)
