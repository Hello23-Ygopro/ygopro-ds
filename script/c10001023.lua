--BT1-020 Iron Wall Magetta
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_RED,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_MAGETTA)
	aux.AddSpecialTrait(c,TRAIT_ALIEN)
	aux.AddEra(c,ERA_CHAMPA_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--cannot be ko-ed
	aux.AddPermanentCannotBeKOed(c,EFFECT_CANNOT_BE_KOED_BATTLE)
end
