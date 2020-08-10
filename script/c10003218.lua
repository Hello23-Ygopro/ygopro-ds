--TB1-059 Maiden Squadron Rozie
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_ROZIE)
	aux.AddSpecialTrait(c,TRAIT_ALIEN,TRAIT_MAIDEN_SQUADRON,TRAIT_UNIVERSE_2)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,TRAIT_CATEGORY_UNIVERSE)
	--battle card
	aux.EnableBattleAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--untap
	aux.AddAutoSkill(c,0,EVENT_PHASE+PHASE_END,nil,aux.SelfSwitchtoActiveOperation,nil,scard.con1)
end
--untap
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return Duel.IsExistingMatchingCard(aux.BattleAreaFilter(Card.IsCharacter,CHARACTER_RIBRIANNE),tp,LOCATION_BATTLE,0,1,nil)
		and Duel.IsExistingMatchingCard(aux.BattleAreaFilter(Card.IsCharacter,CHARACTER_KAKUNSA),tp,LOCATION_BATTLE,0,1,nil)
		and Duel.GetTurnPlayer()==tp and c:IsFaceup() and c:IsRest()
end
