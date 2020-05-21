--BT3-005 Determined Super Saiyan Son Goku
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_SON_GOKU_GT)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_BLACK_STAR_DRAGON_BALL_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_GT,CHAR_CATEGORY_SON_GOKU)
	--battle card
	aux.EnableBattleAttribute(c)
	--critical
	aux.EnableCritical(c)
	--energy cost up
	aux.AddPermanentUpdateEnergyCost(c,2,nil,aux.LifeEqualBelowCondition(PLAYER_SELF,4),LOCATION_BATTLE)
end
scard.specified_cost={COLOR_RED,2}
scard.combo_cost=0
