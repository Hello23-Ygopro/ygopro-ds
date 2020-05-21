--TB2-018 Babidi's Spaceship
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--extra card
	aux.EnableExtraAttribute(c)
	--field
	aux.EnableField(c)
	--to hand
	aux.AddActivateMainSkill(c,0,scard.op1,aux.SelfSwitchtoRestCost,scard.tg1,EFFECT_FLAG_CARD_TARGET)
end
scard.specified_cost={COLOR_RED,1}
--to hand
function scard.thfilter(c)
	return c:IsCharacter(CHARACTER_DABURA,CHARACTER_PUI_PUI,CHARACTER_YAKON) and c:IsAbleToHand()
end
scard.tg1=aux.TargetDecktopTarget(scard.thfilter,1,0,1,HINTMSG_ATOHAND)
scard.op1=aux.TargetDecktopSendtoHandOperation(1,SEQ_DECK_BOTTOM,true)
