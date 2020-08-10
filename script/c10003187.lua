--TB1-031 Whis, Mentor of Beerus
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_WHIS)
	aux.AddSpecialTrait(c,TRAIT_GOD,TRAIT_UNIVERSE_7)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,TRAIT_CATEGORY_UNIVERSE)
	--battle card
	aux.EnableBattleAttribute(c)
	--barrier
	aux.EnableBarrier(c)
	--reduce energy cost
	aux.AddPermanentUpdateEnergyCost(c,-1,nil,nil,LOCATION_BATTLE,LOCATION_HAND,0,aux.TargetBoolFunction(Card.IsCharacter,CHARACTER_BEERUS))
	--1 copy in battle area
	aux.AddPermanentOneCopyBattleArea(c)
end
