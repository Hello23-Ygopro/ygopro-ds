--BT2-047 Whis, The Sacred Guard
local scard,sid=aux.GetID()
function scard.initial_effect(c)
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
scard.specified_cost={COLOR_BLUE,2}
scard.combo_cost=1
