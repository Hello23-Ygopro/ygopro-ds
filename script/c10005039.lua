--BT5-034 Deadly Defender Vegeta
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_VEGETA)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_JANEMBA_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--barrier
	aux.EnableBarrier(c)
	--attack limit
	aux.AddPermanentCannotSelectBattleTarget(c,aux.TargetBoolFunction(Card.IsLeader),scard.con1,0,LOCATION_BATTLE)
	--lose power
	aux.AddPermanentUpdatePower(c,-5000,scard.con1)
end
--lose power
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return Duel.GetTurnPlayer()~=e:GetHandlerPlayer()
		and aux.SelfLeaderCondition(Card.IsColor,COLOR_BLUE)(e,tp,eg,ep,ev,re,r,rp) and c:IsFaceup() and c:IsRest()
end
