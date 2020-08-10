--BT1-032 Overflowing Spirit SSGSS Son Goku
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,2)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_SON_GOKU)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_CHAMPA_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOKU)
	--battle card
	aux.EnableBattleAttribute(c)
	--critical
	aux.EnableCritical(c)
	--gain power
	aux.AddPermanentUpdatePower(c,10000,aux.AND(aux.TurnPlayerCondition(PLAYER_SELF),aux.EnergyEqualAboveCondition(PLAYER_SELF,5)))
end
