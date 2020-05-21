--BT3-123 Hyper Evolution Super Saiyan 4 Son Goku
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_SON_GOKU_GT)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_BABY_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_GT,CHAR_CATEGORY_SON_GOKU)
	--battle card
	aux.EnableBattleAttribute(c)
	--ex-evolve
	aux.EnableEXEvolve(c,scard.evofilter,aux.MergeCost(aux.PaySkillCost(COLOR_RED,1,0),aux.DropCost(aux.HandFilter(nil),LOCATION_HAND,0,2)))
	--ultimate
	aux.EnableUltimate(c)
	--gain skill, damage
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.op1)
	--untap
	aux.AddActivateMainSkill(c,1,scard.op2,scard.cost1,nil,nil,aux.SelfRestCondition)
end
scard.specified_cost={COLOR_RED,5}
scard.combo_cost=1
--ex-evolve
function scard.evofilter(c)
	return c:IsColor(COLOR_RED) and c:IsCharacter(CHARACTER_SON_GOKU_GT) and c:IsEnergyAbove(6)
end
--gain skill, damage
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	--gain power
	aux.AddTempSkillUpdatePower(c,c,2,5000)
	if c:IsPowerAbove(60000) then
		Duel.BreakEffect()
		Duel.Damage(1-tp,1,REASON_EFFECT)
	end
end
--untap
scard.cost1=aux.DropCost(aux.HandFilter(Card.IsColor,COLOR_RED),LOCATION_HAND,0,2)
scard.op2=aux.SelfSwitchtoActiveOperation
