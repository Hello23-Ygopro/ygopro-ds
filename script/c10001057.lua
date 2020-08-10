--BT1-050 Guardian North Kai
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_NORTH_KAI)
	aux.AddSpecialTrait(c,TRAIT_GOD)
	aux.AddEra(c,ERA_BATTLE_OF_GODS_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--blocker
	aux.EnableBlocker(c)
end
