--BT2-021 Sensing Old Kai
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_OLD_KAI)
	aux.AddSpecialTrait(c,TRAIT_GOD)
	aux.AddEra(c,ERA_MAJIN_BUU_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--to hand
	aux.AddAutoSkill(c,0,EVENT_CUSTOM+EVENT_MAIN_PHASE_START,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
scard.specified_cost={COLOR_RED,1}
scard.combo_cost=0
--to hand
function scard.thfilter(c)
	return c:IsCode(CARD_MIRACULOUS_COMEBACK_ULTIMATE_GOHAN) and c:IsAbleToHand()
end
scard.tg1=aux.TargetDecktopTarget(scard.thfilter,3,0,1,HINTMSG_ATOHAND)
scard.op1=aux.TargetDecktopSendtoHandOperation(3,SEQ_DECK_BOTTOM,true)
