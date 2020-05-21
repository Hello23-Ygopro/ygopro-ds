--EX01-02 Comrades Combined Vegeta
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_VEGETA)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_FUTURE_TRUNKS_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--reduce energy cost
	aux.AddPermanentUpdateEnergyCost(c,-1,nil,aux.EnergyExclusiveCondition(Card.IsColor,COLOR_BLUE),LOCATION_HAND+LOCATION_BATTLE)
end
scard.specified_cost={COLOR_BLUE,2}
scard.combo_cost=0
