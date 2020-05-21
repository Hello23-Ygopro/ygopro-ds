--BT5-029 Super Saiyan Son Goku
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_SON_GOKU)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_JANEMBA_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOKU)
	--battle card
	aux.EnableBattleAttribute(c)
end
scard.specified_cost={COLOR_BLUE,2}
scard.combo_cost=0
scard.card_code=CARD_SUPER_SAIYAN_SON_GOKU
