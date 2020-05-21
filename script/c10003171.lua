--TB1-018 Ultimate Evolution Frost
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_FROST)
	aux.AddSpecialTrait(c,TRAIT_FRIEZA_CLAN,TRAIT_ALIEN,TRAIT_UNIVERSE_6)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,TRAIT_CATEGORY_UNIVERSE)
	--battle card
	aux.EnableBattleAttribute(c)
	--evolve
	aux.EnableEvolve(c,aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_FROST),aux.PaySkillCost(COLOR_RED,2,2))
	--triple strike
	aux.EnableTripleStrike(c)
	--tap
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,aux.EvolvePlayCondition)
end
scard.specified_cost={COLOR_RED,2}
scard.combo_cost=0
--tap
function scard.tapfilter(c)
	return c:IsPowerBelow(20000) and c:IsAbleToSwitchToRest()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(scard.tapfilter),0,LOCATION_BATTLE,0,2,HINTMSG_TOREST)
scard.op1=aux.TargetCardsOperation(Duel.SwitchtoRest,REASON_EFFECT)
