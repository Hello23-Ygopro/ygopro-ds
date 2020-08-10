--P-038 Absolute Attack Mira
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_MIRA)
	aux.AddSpecialTrait(c,TRAIT_ANDROID)
	aux.AddEra(c,ERA_DARK_DEMON_REALM_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--over realm
	aux.EnableOverRealm(c,4)
	--cannot activate
	aux.AddPermanentPlayerCannotActivate(c,aux.CannotActivateKeySkillValue(CATEGORY_BLOCKER),aux.SelfAttackerCondition,0,1)
end
