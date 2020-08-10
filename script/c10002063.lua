--BT2-057 Zamasu, The Invincible
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_ZAMASU)
	aux.AddSpecialTrait(c,TRAIT_GOD)
	aux.AddEra(c,ERA_FUTURE_TRUNKS_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--indestructible
	aux.EnableIndestructible(c)
	--reduce energy cost
	aux.AddPermanentUpdateEnergyCost(c,-1,nil,aux.SelfLeaderCondition(Card.IsCharacter,CHARACTER_ZAMASU,CHARACTER_GOKU_BLACK),LOCATION_HAND+LOCATION_BATTLE)
end
