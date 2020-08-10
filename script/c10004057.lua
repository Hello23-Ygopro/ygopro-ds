--BT4-050 Power Barrier Piccolo
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_PICCOLO)
	aux.AddSpecialTrait(c,TRAIT_NAMEKIAN)
	aux.AddEra(c,ERA_FRIEZA_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--barrier
	aux.EnableBarrier(c)
end
