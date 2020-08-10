--TB2-040 Speed Attack Piccolo Jr.
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_PICCOLO_JR)
	aux.AddSpecialTrait(c,TRAIT_NAMEKIAN,TRAIT_WORLD_TOURNAMENT)
	aux.AddEra(c,ERA_WORLD_MA_TOURNAMENT_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--critical
	aux.EnableCritical(c)
end
