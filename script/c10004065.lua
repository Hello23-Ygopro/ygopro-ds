--BT4-058 Namekian Duo Pirina
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_PIRINA)
	aux.AddSpecialTrait(c,TRAIT_NAMEKIAN,TRAIT_ALIEN,TRAIT_UNIVERSE_6)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,TRAIT_CATEGORY_UNIVERSE)
	--battle card
	aux.EnableBattleAttribute(c)
	--draw, gain skill
	local e1=aux.AddActivateMainSkill(c,0,scard.op1,scard.cost1,nil,EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
end
scard.specified_cost={COLOR_GREEN,1}
scard.combo_cost=0
--draw, gain skill
scard.cost1=aux.AbsorbCost(aux.HandFilter(Card.IsSpecialTrait,TRAIT_NAMEKIAN),LOCATION_HAND,0,1)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	--gain power
	aux.AddTempSkillUpdatePower(c,c,1,10000)
	--critical
	aux.AddTempSkillCritical(c,c,2)
end
