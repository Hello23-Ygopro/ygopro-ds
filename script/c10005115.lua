--BT5-097 Dragon Ball Seeker Sorbet
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_SORBET)
	aux.AddSpecialTrait(c,TRAIT_FRIEZAS_ARMY)
	aux.AddEra(c,ERA_RESURRECTION_F_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--search (to hand)
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,aux.SelfPreviousLocationCondition(LOCATION_HAND))
end
scard.specified_cost={COLOR_YELLOW,1}
scard.combo_cost=0
--search (to hand)
function scard.thfilter(c)
	return c:IsHasEffect(EFFECT_DRAGON_BALL) and c:IsAbleToHand()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.thfilter,LOCATION_DECK,0,0,1,HINTMSG_ATOHAND)
scard.op1=aux.TargetSendtoHandOperation(true)
