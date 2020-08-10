--BT4-091 Adoptive Father Son Gohan
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_SON_GOHAN)
	aux.AddSpecialTrait(c,TRAIT_EARTHLING,TRAIT_GOKUS_LINEAGE)
	aux.AddEra(c,ERA_GALACTIC_PATROLMAN_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOHAN)
	--battle card
	aux.EnableBattleAttribute(c)
	--swap
	aux.EnableSwap(c,2,aux.FilterBoolFunction(Card.IsSpecialTrait,TRAIT_GOKUS_LINEAGE))
	--blocker
	aux.EnableBlocker(c)
end
