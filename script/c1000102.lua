--P-087 Inferno Forged Hell Fighter 17
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_HELL_FIGHTER_17)
	aux.AddSpecialTrait(c,TRAIT_ANDROID,TRAIT_MACHINE_MUTANT)
	aux.AddEra(c,ERA_SUPER_17_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--dual attack
	aux.EnableDualAttack(c)
end
