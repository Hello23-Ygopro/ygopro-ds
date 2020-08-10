--BT2-020 Kibito
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_RED,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_KIBITO)
	aux.AddSpecialTrait(c,TRAIT_GOD)
	aux.AddEra(c,ERA_MAJIN_BUU_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
end
