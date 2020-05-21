--SD3-05 Power Aura Mira
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_MIRA)
	aux.AddSpecialTrait(c,TRAIT_ANDROID)
	aux.AddEra(c,ERA_DARK_DEMON_REALM_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--over realm
	aux.EnableOverRealm(c,3)
	--gain power
	aux.AddPermanentUpdatePower(c,5000,aux.WarpEqualAboveCondition(PLAYER_SELF,3))
	aux.AddPermanentUpdatePower(c,5000,aux.WarpEqualAboveCondition(PLAYER_SELF,5))
end
scard.combo_cost=0
