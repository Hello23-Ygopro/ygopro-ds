--TB2-054 Unending Moves Yamcha
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_YAMCHA)
	aux.AddSpecialTrait(c,TRAIT_EARTHLING,TRAIT_WORLD_TOURNAMENT)
	aux.AddEra(c,ERA_WORLD_MA_TOURNAMENT_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--barrier
	aux.EnableBarrier(c)
	--gain power
	aux.AddPermanentUpdatePower(c,10000,aux.ExistingCardCondition(aux.BattleAreaFilter(Card.IsCode,CARD_UNENDING_MOVES_TIEN_SHINHAN),LOCATION_BATTLE))
	--critical
	aux.EnableCritical(c,aux.ExistingCardCondition(aux.BattleAreaFilter(Card.IsCode,CARD_UNENDING_MOVES_TIEN_SHINHAN),LOCATION_BATTLE))
end
