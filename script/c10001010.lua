--BT1-008 Bewitching God Vados
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_VADOS)
	aux.AddSpecialTrait(c,TRAIT_GOD)
	aux.AddEra(c,ERA_CHAMPA_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--dual attack
	aux.EnableDualAttack(c)
	--play
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
scard.specified_cost={COLOR_RED,2}
scard.combo_cost=1
--play
function scard.playfilter(c,e,tp)
	return c:IsSpecialTrait(TRAIT_ALIEN) and c:IsPowerBelow(15000) and c:IsCanBePlayed(e,0,tp,false,false)
end
scard.tg1=aux.TargetDecktopTarget(scard.playfilter,3,0,1,HINTMSG_PLAY)
scard.op1=aux.TargetDecktopPlayOperation(3,SEQ_DECK_SHUFFLE,POS_FACEUP_ACTIVE)
