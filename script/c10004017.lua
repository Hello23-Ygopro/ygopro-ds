--BT4-015 Mr. Buu
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_RED,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_MR_BUU)
	aux.AddSpecialTrait(c,TRAIT_MAJIN)
	aux.AddEra(c,ERA_BABY_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
end
