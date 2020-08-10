--BT2-086 Growing Evil Lifeform Cell
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_CELL)
	aux.AddSpecialTrait(c,TRAIT_ANDROID)
	aux.AddEra(c,ERA_ANDROID_CELL_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--union-absorb
	aux.EnableUnionAbsorb(c,scard.uniafilter,aux.AbsorbCost(aux.HandFilter(Card.IsCharacter,CHARACTER_ANDROID_17),LOCATION_HAND,0,0,1))
end
--union-absorb
function scard.uniafilter(c)
	return c:IsCharacter(CHARACTER_CELL) and c:IsEnergyBelow(5)
end
