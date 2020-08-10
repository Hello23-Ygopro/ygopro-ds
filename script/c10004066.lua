--BT4-059 Titanic Ambition Lord Slug
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,2)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_LORD_SLUG)
	aux.AddSpecialTrait(c,TRAIT_NAMEKIAN,TRAIT_SLUGS_ARMY)
	aux.AddEra(c,ERA_LORD_SLUG_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--ex-evolve
	aux.EnableEXEvolve(c,scard.evofilter,aux.MergeCost(aux.PaySkillCost(COLOR_GREEN,2,0),aux.DropCost(aux.HandFilter(nil),LOCATION_HAND,0,1)))
	--double strike
	aux.EnableDoubleStrike(c)
	--bond (drop)
	aux.EnableBond(c)
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,aux.BondCondition(3,Card.IsSpecialTrait,TRAIT_SLUGS_ARMY))
end
--ex-evolve
function scard.evofilter(c)
	return c:IsCharacter(CHARACTER_LORD_SLUG) and c:IsEnergyAbove(4)
end
--bond (drop)
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.HandFilter(Card.IsAbleToDrop),0,LOCATION_HAND,0,3,HINTMSG_DROP)
scard.op1=aux.TargetCardsOperation(Duel.SendtoDrop,REASON_EFFECT)
