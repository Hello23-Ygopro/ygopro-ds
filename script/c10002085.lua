--BT2-075 Supreme DNA Son Gohan
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_SON_GOHAN_CHILDHOOD)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_ANDROID_CELL_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOHAN)
	--battle card
	aux.EnableBattleAttribute(c)
	--reduce energy cost
	aux.AddPermanentUpdateEnergyCost(c,-2,nil,scard.con1,LOCATION_HAND+LOCATION_BATTLE)
end
scard.specified_cost={COLOR_GREEN,1}
scard.combo_cost=0
--reduce energy cost
scard.con1=aux.ExistingCardCondition(aux.DropAreaFilter(Card.IsCharacter,CHARACTER_SON_GOKU),LOCATION_DROP,0,2)
