--BT4-113 Gravy, Lightning's Might
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_GRAVY)
	aux.AddSpecialTrait(c,TRAIT_DEMON_GOD)
	aux.AddEra(c,ERA_DARK_DEMON_REALM_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--dark over realm
	aux.EnableDarkOverRealm(c,2,aux.PaySkillCost(COLOR_COLORLESS,0,2))
end
