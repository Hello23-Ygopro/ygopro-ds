--BT1-086 Golden Frieza, Resurrected Terror
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_FRIEZA)
	aux.AddSpecialTrait(c,TRAIT_FRIEZA_CLAN,TRAIT_FRIEZAS_ARMY)
	aux.AddEra(c,ERA_RESURRECTION_F_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--evolve
	aux.EnableEvolve(c,aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_FRIEZA),aux.PaySkillCost(COLOR_YELLOW,2,4))
	--triple strike
	aux.EnableTripleStrike(c)
	--drop, tap
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,nil,scard.op1,EFFECT_FLAG_CARD_TARGET,aux.EvolvePlayCondition)
end
scard.specified_cost={COLOR_YELLOW,3}
scard.combo_cost=1
--drop, tap
function scard.dropfilter(c)
	return c:IsRest() and c:IsAbleToDrop()
end
function scard.tapfilter(c,e)
	return c:IsAbleToSwitchToRest() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g1=Duel.GetMatchingGroup(aux.BattleAreaFilter(scard.dropfilter),tp,LOCATION_BATTLE,LOCATION_BATTLE,c)
	Duel.SendtoDrop(g1,REASON_EFFECT)
	local g2=Duel.GetMatchingGroup(aux.BattleAreaFilter(scard.tapfilter),tp,LOCATION_BATTLE,LOCATION_BATTLE,c,e)
	Duel.BreakEffect()
	Duel.SetTargetCard(g2)
	Duel.SwitchtoRest(g2,REASON_EFFECT)
end
