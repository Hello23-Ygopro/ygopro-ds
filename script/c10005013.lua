--BT5-011 Deadly Defender Krillin
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_KRILLIN_YOUTH)
	aux.AddSpecialTrait(c,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_FORTUNETELLER_BABA_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--barrier
	aux.EnableBarrier(c)
	--attack limit
	aux.AddPermanentCannotSelectBattleTarget(c,aux.TargetBoolFunction(Card.IsLeader),scard.con1,0,LOCATION_BATTLE)
	--lose power
	aux.AddPermanentUpdatePower(c,-5000,scard.con1)
end
scard.specified_cost={COLOR_RED,2}
scard.combo_cost=0
--lose power
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return Duel.GetTurnPlayer()~=e:GetHandlerPlayer()
		and aux.SelfLeaderCondition(Card.IsColor,COLOR_RED)(e,tp,eg,ep,ev,re,r,rp) and c:IsFaceup() and c:IsRest()
end
