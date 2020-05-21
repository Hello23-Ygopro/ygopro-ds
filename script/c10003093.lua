--BT3-084 Desperate Warrior Super Saiyan Bardock
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_BARDOCK)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_BARDOCK_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--ex-evolve
	aux.EnableEXEvolve(c,scard.evofilter,aux.DropCost(aux.HandFilter(nil),LOCATION_HAND,0,2))
	--gain power
	aux.AddPermanentUpdatePower(c,5000,aux.ExistingCardCondition(aux.EnergyAreaFilter(Card.IsRest),0,LOCATION_ENERGY,6))
	--triple strike
	aux.EnableTripleStrike(c,aux.ExistingCardCondition(aux.EnergyAreaFilter(Card.IsRest),0,LOCATION_ENERGY,6))
	--tap
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,aux.EvolvePlayCondition)
end
scard.specified_cost={COLOR_YELLOW,2}
scard.combo_cost=1
--ex-evolve
function scard.evofilter(c)
	return c:IsColor(COLOR_YELLOW) and c:IsCharacter(CHARACTER_BARDOCK) and c:IsEnergyAbove(5)
end
--tap
function scard.tapfilter(c,e)
	return c:IsAbleToSwitchToRest() and c:IsCanBeEffectTarget(e)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	local g1=Duel.GetMatchingGroup(aux.BattleAreaFilter(scard.tapfilter),tp,0,LOCATION_BATTLE,nil,e)
	local g2=Duel.GetMatchingGroup(aux.EnergyAreaFilter(scard.tapfilter),tp,0,LOCATION_ENERGY,nil,e)
	g1:Merge(g2)
	Duel.SetTargetCard(g1)
end
scard.op1=aux.TargetCardsOperation(Duel.SwitchtoRest,REASON_EFFECT)
