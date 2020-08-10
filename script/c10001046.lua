--BT1-039 Trunks
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_TRUNKS_YOUTH)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_BATTLE_OF_GODS_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
end
