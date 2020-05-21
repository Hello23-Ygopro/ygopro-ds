--EX03-30 Toppo Unleashed
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_TOPPO)
	aux.AddSpecialTrait(c,TRAIT_ALIEN,TRAIT_PRIDE_TROOPERS,TRAIT_UNIVERSE_11)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,TRAIT_CATEGORY_UNIVERSE)
	--battle card
	aux.EnableBattleAttribute(c)
	--ex-evolve
	aux.EnableEXEvolve(c,scard.evofilter,aux.MergeCost(aux.PaySkillCost(COLOR_COLORLESS,0,1),aux.DropDecktopCost(3)))
	--barrier
	aux.EnableBarrier(c)
	--blocker
	aux.EnableBlocker(c)
	--draw, gain skill
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,nil,scard.op1,nil,scard.con1)
end
scard.combo_cost=0
--ex-evolve
function scard.evofilter(c)
	return c:IsCharacter(CHARACTER_TOPPO) and c:IsEnergyAbove(4)
end
--draw, gain skill
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return aux.EvolvePlayCondition(e,tp,eg,ep,ev,re,r,rp)
		and aux.SelfLeaderCondition(Card.IsSpecialTrait,TRAIT_UNIVERSE_11)(e,tp,eg,ep,ev,re,r,rp)
		and Duel.IsExistingMatchingCard(aux.DropAreaFilter(Card.IsSpecialTrait,TRAIT_UNIVERSE_11),tp,LOCATION_DROP,0,8,nil)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,2,REASON_EFFECT)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	--double strike
	aux.AddTempSkillCustom(c,c,1,EFFECT_DOUBLE_STRIKE)
	--critical
	aux.AddTempSkillCritical(c,c,2)
end
