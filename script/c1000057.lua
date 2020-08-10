--P-049 Burst Attack Son Gohan
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_RED,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_SON_GOHAN_ADOLESCENCE)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_EARTHLING,TRAIT_UNIVERSE_7)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOHAN,TRAIT_CATEGORY_UNIVERSE)
	--battle card
	aux.EnableBattleAttribute(c)
	--critical
	aux.EnableCritical(c)
	--draw
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,aux.DuelOperation(Duel.Draw,PLAYER_SELF,2,REASON_EFFECT),nil,aux.HandEqualBelowCondition(PLAYER_SELF,4))
end
