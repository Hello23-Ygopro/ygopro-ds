--BT3-047 The Ultimate Evil, Majin Buu
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_MAJIN_BUU)
	aux.AddSpecialTrait(c,TRAIT_MAJIN)
	aux.AddEra(c,ERA_MAJIN_BUU_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--ex-evolve
	aux.EnableEXEvolve(c,scard.evofilter,aux.MergeCost(aux.PaySkillCost(COLOR_BLUE,1,0),aux.DropCost(aux.HandFilter(nil),LOCATION_HAND,0,2)))
	--triple strike
	aux.EnableTripleStrike(c)
	--untap, gain skill
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,nil,scard.op1,nil,aux.EvolvePlayCondition)
end
scard.specified_cost={COLOR_BLUE,3}
scard.combo_cost=1
--ex-evolve
function scard.evofilter(c)
	return c:IsCharacter(CHARACTER_MAJIN_BUU) and c:IsEnergyAbove(5)
end
--untap, gain skill
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	Duel.SwitchtoActive(c,REASON_EFFECT)
	--gain power
	aux.AddTempSkillUpdatePower(c,c,1,30000)
end
