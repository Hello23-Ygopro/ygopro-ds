--BT2-032 Piccolo's Help
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_RED,2)
	--extra card
	aux.EnableExtraAttribute(c)
	--play
	aux.AddActivateMainSkill(c,0,scard.op1,nil,scard.tg1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
--play
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetMatchingGroupCount(aux.HandFilter(nil),tp,LOCATION_HAND,0,e:GetHandler())<=3
end
function scard.playfilter(c,e,tp)
	return c:IsCharacter(CHARACTER_GOTENKS) and c:IsPowerBelow(15000) and c:IsCanBePlayed(e,0,tp,false,false)
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.DropAreaFilter(scard.playfilter),LOCATION_DROP,0,1,1,HINTMSG_PLAY)
scard.op1=aux.TargetPlayOperation(POS_FACEUP_ACTIVE)
