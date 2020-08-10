--BT1-016 Unceasing Evolution Frost
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_RED,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_FROST)
	aux.AddSpecialTrait(c,TRAIT_ALIEN,TRAIT_FRIEZA_CLAN)
	aux.AddEra(c,ERA_CHAMPA_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--evolve
	aux.EnableEvolve(c,aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_FROST),aux.PaySkillCost(COLOR_RED,2,0))
	--double strike
	aux.EnableDoubleStrike(c)
end
