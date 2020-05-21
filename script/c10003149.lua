--SD3-04 Encroaching Threat Masked Saiyan
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_MASKED_SAIYAN)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_DARK_DEMON_REALM_SAGA)
	aux.AddCategory(c,NAME_CATEGORY_MASKED)
	--battle card
	aux.EnableBattleAttribute(c)
	--attack active
	aux.AddSinglePermanentSkill(c,EFFECT_ATTACK_ACTIVE_MODE)
	--reduce energy cost
	aux.AddPermanentUpdateEnergyCost(c,-1,nil,aux.WarpEqualAboveCondition(PLAYER_SELF,7),LOCATION_HAND+LOCATION_WARP)
end
scard.combo_cost=0
