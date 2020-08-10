--TB1-084 Hero Combination Vuon
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_VUON)
	aux.AddSpecialTrait(c,TRAIT_ALIEN,TRAIT_PRIDE_TROOPERS,TRAIT_UNIVERSE_11)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,TRAIT_CATEGORY_UNIVERSE)
	--battle card
	aux.EnableBattleAttribute(c)
	--gain power
	aux.AddPermanentUpdatePower(c,5000,scard.con1)
	--untap
	aux.AddAutoSkill(c,0,EVENT_PHASE+PHASE_END,nil,aux.SelfSwitchtoActiveOperation,nil,aux.AND(aux.TurnPlayerCondition(PLAYER_SELF),aux.SelfRestCondition))
end
--untap
function scard.con1(e)
	local tp=e:GetHandlerPlayer()
	return Duel.GetTurnPlayer()==tp
		and Duel.IsExistingMatchingCard(aux.BattleAreaFilter(Card.IsSpecialTrait,TRAIT_UNIVERSE_11),tp,LOCATION_BATTLE,0,1,e:GetHandler())
end
