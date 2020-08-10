--P-054 Infinite Alertness Dyspo
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_DYSPO)
	aux.AddSpecialTrait(c,TRAIT_ALIEN,TRAIT_PRIDE_TROOPERS,TRAIT_UNIVERSE_11)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,TRAIT_CATEGORY_UNIVERSE)
	--battle card
	aux.EnableBattleAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--reduce energy cost
	aux.AddPermanentUpdateEnergyCost(c,-2,nil,aux.ExistingCardCondition(aux.DropAreaFilter(Card.IsSpecialTrait,TRAIT_UNIVERSE_11),LOCATION_DROP,0,4))
	--untap
	aux.AddAutoSkill(c,0,EVENT_PHASE+PHASE_END,nil,aux.SelfSwitchtoActiveOperation,nil,aux.AND(aux.TurnPlayerCondition(PLAYER_SELF),aux.SelfRestCondition))
end
