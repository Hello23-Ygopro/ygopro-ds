--BT5-078 Infernal Messenger
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--extra card
	aux.EnableExtraAttribute(c)
	--to hand
	aux.AddActivateMainSkill(c,0,scard.op1,nil,scard.tg1,EFFECT_FLAG_CARD_TARGET,aux.SelfLeaderCondition(scard.lfilter))
end
scard.specified_cost={COLOR_GREEN,1}
--to hand
function scard.lfilter(c)
	return c:IsColor(COLOR_GREEN) and c:IsSpecialTrait(TRAIT_ANDROID)
end
function scard.thfilter(c)
	return c:IsCharacter(CHARACTER_ANDROID_17,CHARACTER_HELL_FIGHTER_17,CHARACTER_SUPER_17) and c:IsAbleToHand()
end
scard.tg1=aux.TargetDecktopTarget(scard.thfilter,10,0,2,HINTMSG_ATOHAND)
scard.op1=aux.TargetDecktopSendtoHandOperation(10,SEQ_DECK_SHUFFLE,true)
