--EX03-08 Awe-Inspiring Intimidator SSB Vegito
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_VEGITO)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_FUTURE_TRUNKS_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--barrier
	aux.EnableBarrier(c,scard.con1)
	--attack limit
	aux.AddPermanentCannotSelectBattleTarget(c,aux.TargetBoolFunction(Card.IsLeader),scard.con1,0,LOCATION_BATTLE)
	--draw
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,nil,aux.DuelOperation(Duel.Draw,PLAYER_SELF,1,REASON_EFFECT),nil,aux.EnergyEqualAboveCondition(PLAYER_SELF,5))
end
--barrier, attack limit
scard.con1=aux.AND(aux.SelfLeaderCondition(Card.IsColor,COLOR_BLUE),aux.SelfRestCondition)
