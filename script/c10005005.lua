--BT5-004 Son Goku
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_RED,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_SON_GOKU_CHILDHOOD)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_PILAF_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOKU)
	aux.AddCode(c,CARD_SON_GOKU)
	--battle card
	aux.EnableBattleAttribute(c)
end
