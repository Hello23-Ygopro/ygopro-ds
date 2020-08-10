--BT2-047 Whis, The Sacred Guard
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,2)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_WHIS)
	aux.AddSpecialTrait(c,TRAIT_GOD)
	aux.AddEra(c,ERA_FUTURE_TRUNKS_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--cannot be ko-ed
	aux.AddPermanentCannotBeKOed(c,EFFECT_CANNOT_BE_KOED_EFFECT,aux.indoval)
	--cannot leave
	aux.AddPermanentCannotLeave(c)
end
