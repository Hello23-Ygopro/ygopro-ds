--BT1-062 Son Gohan, Family of Justice
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_SON_GOHAN_ADOLESCENCE)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_BROLY_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOHAN)
	--battle card
	aux.EnableBattleAttribute(c)
	--blocker
	aux.EnableBlocker(c)
end
