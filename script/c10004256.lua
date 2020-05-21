--TB2-053 Toughened Up Krillin
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_KRILLIN_CHILDHOOD)
	aux.AddSpecialTrait(c,TRAIT_EARTHLING,TRAIT_WORLD_TOURNAMENT)
	aux.AddEra(c,ERA_WORLD_MA_TOURNAMENT_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--gain power
	aux.AddPermanentUpdatePower(c,5000,aux.ExistingCardCondition(aux.BattleAreaFilter(Card.IsCode,CARD_TOUGHENED_UP_CHIAOTZU),LOCATION_BATTLE))
	--critical
	aux.EnableCritical(c,aux.ExistingCardCondition(aux.BattleAreaFilter(Card.IsCode,CARD_TOUGHENED_UP_CHIAOTZU),LOCATION_BATTLE))
end
scard.specified_cost={COLOR_YELLOW,2}
scard.combo_cost=0
