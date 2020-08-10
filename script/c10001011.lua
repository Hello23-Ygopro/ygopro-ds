--BT1-009 Calm-Hearted Vados
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_RED,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_VADOS)
	aux.AddSpecialTrait(c,TRAIT_GOD)
	aux.AddEra(c,ERA_CHAMPA_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--to hand
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--to hand
function scard.thfilter(c)
	return c:IsColor(COLOR_RED) and c:IsSpecialTrait(TRAIT_ALIEN) and c:IsAbleToHand()
end
scard.tg1=aux.TargetDecktopTarget(scard.thfilter,3,0,1,HINTMSG_ATOHAND)
scard.op1=aux.TargetDecktopSendtoHandOperation(3,SEQ_DECK_SHUFFLE,true)
