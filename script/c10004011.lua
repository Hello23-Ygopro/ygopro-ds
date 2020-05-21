--BT4-009 Power of Friendship Pan
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_PAN)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_BABY_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--play
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
scard.specified_cost={COLOR_RED,2}
scard.combo_cost=0
--play
function scard.playfilter(c,e,tp)
	return c:IsBattle() and c:IsPowerBelow(15000)
		and c:IsCharacterSetCard(CHAR_CATEGORY_GT) and c:IsCanBePlayed(e,0,tp,false,false)
end
scard.tg1=aux.TargetDecktopTarget(scard.playfilter,5,0,1,HINTMSG_PLAY)
scard.op1=aux.TargetDecktopPlayOperation(5,SEQ_DECK_SHUFFLE,POS_FACEUP_ACTIVE)
