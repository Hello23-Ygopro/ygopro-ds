--P-077 Everybody's Pal Yamcha
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_RED,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_YAMCHA)
	aux.AddSpecialTrait(c,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_PILAF_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--to hand
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--to hand
function scard.thfilter(c)
	return c:IsSpecialTrait(TRAIT_EARTHLING) and c:IsAbleToHand()
end
scard.tg1=aux.TargetDecktopTarget(scard.thfilter,3,0,1,HINTMSG_ATOHAND)
scard.op1=aux.TargetDecktopSendtoHandOperation(3,SEQ_DECK_SHUFFLE,true)
