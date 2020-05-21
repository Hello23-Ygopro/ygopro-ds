--BT4-027 City Patrol Great Saiyaman
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_SON_GOHAN_ADOLESCENCE)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_HIRUDEGARN_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOHAN)
	--battle card
	aux.EnableBattleAttribute(c)
	--barrier
	aux.EnableBarrier(c)
	--blocker
	aux.EnableBlocker(c)
	--reduce energy cost
	aux.AddPermanentUpdateEnergyCost(c,-2,nil,aux.ExistingCardCondition(aux.FaceupFilter(Card.IsCode,CARD_CITY_PATROL_GREAT_SAIYAMAN_2)))
end
scard.specified_cost={COLOR_BLUE,1}
scard.combo_cost=0
