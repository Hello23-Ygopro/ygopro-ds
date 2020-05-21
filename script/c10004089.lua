--BT4-079 Unbroken Dynasty Son Goku
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_SON_GOKU_CHILDHOOD)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_GOKUS_LINEAGE)
	aux.AddEra(c,ERA_KING_PICCOLO_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOKU)
	--battle card
	aux.EnableBattleAttribute(c)
	--swap
	aux.EnableSwap(c,2,aux.FilterBoolFunction(Card.IsSpecialTrait,TRAIT_GOKUS_LINEAGE),scard.cost1)
end
scard.specified_cost={COLOR_YELLOW,1}
scard.combo_cost=0
--swap
scard.cost1=aux.MergeCost(aux.PaySkillCost(COLOR_YELLOW,1,0),aux.DropCost(aux.HandFilter(nil),LOCATION_HAND,0,1,1,true))
