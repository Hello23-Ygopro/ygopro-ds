--BT5-074 General Rilldo
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_GENERAL_RILLDO)
	aux.AddSpecialTrait(c,TRAIT_MACHINE_MUTANT)
	aux.AddEra(c,ERA_SUPER_17_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
end
scard.card_code=CARD_GENERAL_RILLDO
