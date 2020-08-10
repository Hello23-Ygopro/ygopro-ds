--BT3-045 Agent of Resurrection, Babidi
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_EVIL_WIZARD_BABIDI)
	aux.AddSpecialTrait(c,TRAIT_EVIL_WIZARD)
	aux.AddEra(c,ERA_MAJIN_BUU_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--to hand
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--to hand
function scard.thfilter(c)
	return c:IsCharacter(CHARACTER_MAJIN_BUU) and c:IsAbleToHand()
end
scard.tg1=aux.TargetDecktopTarget(scard.thfilter,3,0,1,HINTMSG_ATOHAND)
scard.op1=aux.TargetDecktopSendtoHandOperation(3,SEQ_DECK_SHUFFLE,true)
