--TB1-097 Son Goku, The Awakened Power
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,4)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_SON_GOKU)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_UNIVERSE_7)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOKU,TRAIT_CATEGORY_UNIVERSE)
	--battle card
	aux.EnableBattleAttribute(c)
	--ex-evolve
	aux.EnableEXEvolve(c,scard.evofilter,scard.cost1)
	--ultimate
	aux.EnableUltimate(c)
	--victory strike
	aux.EnableVictoryStrike(c)
	--cannot negate attack
	aux.AddSinglePermanentSkill(c,EFFECT_CANNOT_NEGATE_ATTACK)
	--cannot negate skill
	aux.AddSinglePermanentSkill(c,EFFECT_CANNOT_DISEFFECT)
end
--ex-evolve
function scard.evofilter(c)
	return c:IsSpecialTrait(TRAIT_UNIVERSE_7) and c:IsCharacter(CHARACTER_SON_GOKU) and c:IsEnergyAbove(6)
end
scard.cost1=aux.MergeCost(aux.PaySkillCost(COLOR_COLORLESS,0,1),aux.DropCost(aux.HandFilter(Card.IsSpecialTrait,TRAIT_UNIVERSE_7),LOCATION_HAND,0,1))
