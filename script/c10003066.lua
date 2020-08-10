--BT3-060 Dauntless Spirit SSB Vegeta
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,3)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_VEGETA)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_FUTURE_TRUNKS_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--ex-evolve
	aux.EnableEXEvolve(c,scard.evofilter,aux.MergeCost(aux.PaySkillCost(COLOR_GREEN,1,0),aux.DropCost(aux.HandFilter(nil),LOCATION_HAND,0,1)))
	--double strike
	aux.EnableDoubleStrike(c)
	--drop, gain skill
	aux.AddSingleAutoSkill(c,0,EVENT_DAMAGING,nil,scard.op1)
end
--ex-evolve
function scard.evofilter(c)
	return c:IsColor(COLOR_GREEN) and c:IsCharacter(CHARACTER_VEGETA) and c:IsEnergyAbove(3)
end
--drop, gain skill
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DROP)
	local g=Duel.SelectMatchingCard(tp,aux.HandFilter(Card.IsAbleToDrop),tp,LOCATION_HAND,0,0,1,nil)
	if g:GetCount()==0 or Duel.SendtoDrop(g,REASON_EFFECT)==0 then return end
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	--critical
	aux.AddTempSkillCritical(c,c,1)
end
