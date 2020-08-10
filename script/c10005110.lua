--BT5-092 Deadly Defender Frieza
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_FRIEZA)
	aux.AddSpecialTrait(c,TRAIT_FRIEZA_CLAN,TRAIT_FRIEZAS_ARMY)
	aux.AddEra(c,ERA_RESURRECTION_F_SAGA)
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
	return Duel.GetTurnPlayer()==e:GetHandlerPlayer()
		and aux.SelfLeaderCondition(Card.IsColor,COLOR_YELLOW)(e,tp,eg,ep,ev,re,r,rp) and c:IsFaceup() and c:IsRest()
end
