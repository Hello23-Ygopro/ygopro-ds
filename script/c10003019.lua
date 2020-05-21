--BT3-018 Meta-Rilldo, Form Perfected
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_GENERAL_RILLDO)
	aux.AddSpecialTrait(c,TRAIT_MACHINE_MUTANT)
	aux.AddEra(c,ERA_BLACK_STAR_DRAGON_BALL_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--ex-evolve
	aux.EnableEXEvolve(c,scard.evofilter,aux.MergeCost(aux.PaySkillCost(COLOR_RED,1,0),aux.DropCost(aux.HandFilter(nil),LOCATION_HAND,0,1)))
	--double strike
	aux.EnableDoubleStrike(c)
	--draw, gain skill
	local e1=aux.AddActivateMainSkill(c,0,scard.op1,scard.cost1,nil,EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
end
scard.specified_cost={COLOR_RED,4}
scard.combo_cost=1
--ex-evolve
function scard.evofilter(c)
	return c:IsColor(COLOR_RED) and c:IsCharacter(CHARACTER_GENERAL_RILLDO) and c:IsEnergyAbove(5)
end
--draw, gain skill
function scard.costfilter(c)
	return c:IsCode(CARD_PLANET_M2) and (c:IsFaceup() or c:IsLocation(LOCATION_HAND))
end
scard.cost1=aux.DropCost(scard.costfilter,LOCATION_HAND+LOCATION_BATTLE,0,1)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,2,REASON_EFFECT)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local tc1=Duel.SelectMatchingCard(tp,aux.LeaderAreaFilter(Card.IsCanBeEffectTarget),tp,0,LOCATION_LEADER,1,1,nil,e):GetFirst()
	if tc1 then
		Duel.BreakEffect()
		Duel.SetTargetCard(tc1)
		--lose power
		aux.AddTempSkillUpdatePower(c,tc1,1,-5000)
	end
	local g=Duel.GetMatchingGroup(aux.BattleAreaFilter(Card.IsCanBeEffectTarget),tp,0,LOCATION_BATTLE,nil,e)
	if g:GetCount()==0 then return end
	Duel.BreakEffect()
	Duel.SetTargetCard(g)
	for tc2 in aux.Next(g) do
		--lose power
		aux.AddTempSkillUpdatePower(c,tc2,2,-10000)
	end
end
