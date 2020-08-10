--TB1-054 Energy Guard Android 17
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_ANDROID_17)
	aux.AddSpecialTrait(c,TRAIT_ANDROID,TRAIT_UNIVERSE_7)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,NAME_CATEGORY_ANDROID,TRAIT_CATEGORY_UNIVERSE)
	--battle card
	aux.EnableBattleAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--untap
	aux.AddAutoSkill(c,0,EVENT_PHASE+PHASE_END,nil,aux.SelfSwitchtoActiveOperation,nil,aux.AND(aux.TurnPlayerCondition(PLAYER_SELF),aux.SelfRestCondition))
end
