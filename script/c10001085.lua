--BT1-074 Rampaging Lifeform Bio-Broly
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_BROLY)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_BIO_WARRIOR)
	aux.AddEra(c,ERA_BROLY_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--evolve
	aux.EnableEvolve(c,aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_BROLY),aux.PaySkillCost(COLOR_GREEN,2,2))
	--double strike
	aux.EnableDoubleStrike(c)
	--drop
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,aux.EvolvePlayCondition)
end
scard.specified_cost={COLOR_GREEN,2}
scard.combo_cost=1
--drop
scard.tg1=aux.TargetCardFunction(PLAYER_OPPO,aux.HandFilter(Card.IsAbleToDrop),0,LOCATION_HAND,2,2,HINTMSG_DROP)
scard.op1=aux.TargetCardsOperation(Duel.SendtoDrop,REASON_EFFECT)
