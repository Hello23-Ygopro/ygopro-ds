--BT1-034 Mighty Striker Son Gohan
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,1)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_SON_GOHAN_ADOLESCENCE)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_RESURRECTION_F_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOHAN)
	--battle card
	aux.EnableBattleAttribute(c)
	--double strike
	aux.EnableDoubleStrike(c)
end
