--BT3-028 Grand Tour Spaceship
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--extra card
	aux.EnableExtraAttribute(c)
	--play
	aux.AddActivateMainSkill(c,0,scard.op1,nil,scard.tg1,EFFECT_FLAG_CARD_TARGET)
end
scard.specified_cost={COLOR_RED,1}
--play
function scard.playfilter(c,e,tp)
	return c:IsCharacter(CHARACTER_SON_GOKU_GT,CHARACTER_TRUNKS_GT,CHARACTER_PAN,CHARACTER_GIRU)
		and c:IsPowerBelow(15000) and c:IsCanBePlayed(e,0,tp,false,false)
end
scard.tg1=aux.TargetDecktopTarget(scard.playfilter,7,0,1,HINTMSG_PLAY)
scard.op1=aux.TargetDecktopPlayOperation(7,SEQ_DECK_SHUFFLE,POS_FACEUP_ACTIVE)
