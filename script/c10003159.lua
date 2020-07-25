--TB1-006 Majin Buu, Full of Energy
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_MAJIN_BUU)
	aux.AddSpecialTrait(c,TRAIT_MAJIN,TRAIT_UNIVERSE_7)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,TRAIT_CATEGORY_UNIVERSE)
	--battle card
	aux.EnableBattleAttribute(c)
	--evolve
	aux.EnableEvolve(c,scard.evofilter,aux.PaySkillCost(COLOR_COLORLESS,0,3))
	--double strike
	aux.EnableDoubleStrike(c)
	--barrier
	aux.EnableBarrier(c)
	--gain skill
	aux.AddActivateMainSkill(c,0,scard.op1,scard.cost1,nil,EFFECT_FLAG_CARD_TARGET)
end
scard.specified_cost={COLOR_RED,1}
scard.combo_cost=0
--evolve
function scard.evofilter(c)
	return c:IsColor(COLOR_RED) and c:IsCharacter(CHARACTER_MAJIN_BUU)
end
--gain skill
scard.cost1=aux.SendtoHandCost(aux.LifeAreaFilter(nil),LOCATION_LIFE,0,1)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	--gain power
	aux.AddTempSkillUpdatePower(c,c,1,5000)
end
