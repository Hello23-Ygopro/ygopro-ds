--P-004 Energy Attack Trunks
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_TRUNKS_YOUTH)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_BATTLE_OF_GODS_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--reduce energy cost
	aux.AddPermanentUpdateEnergyCost(c,-1,nil,aux.ExistingCardCondition(aux.BattleAreaFilter(Card.IsCharacter,CHARACTER_TRUNKS_FUTURE),LOCATION_BATTLE))
	--gain power
	aux.AddPermanentUpdatePower(c,5000,aux.AND(aux.TurnPlayerCondition(PLAYER_SELF),aux.EnergyEqualAboveCondition(PLAYER_SELF,3)))
end
