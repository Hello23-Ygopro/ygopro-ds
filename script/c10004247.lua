--TB2-046 Trusting Relationship Kami
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_KAMI)
	aux.AddSpecialTrait(c,TRAIT_GOD,TRAIT_WORLD_TOURNAMENT)
	aux.AddEra(c,ERA_WORLD_MA_TOURNAMENT_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--gain skill (barrier)
	aux.EnableBarrier(c,aux.ExistingCardCondition(aux.BattleAreaFilter(Card.IsCode,CARD_TRUSTING_RELATIONSHIP_POPO),LOCATION_BATTLE))
end
