--SD7-05 Mega Focus Son Goku
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_SON_GOKU_CHILDHOOD)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_FORTUNETELLER_BABA_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOKU)
	--battle card
	aux.EnableBattleAttribute(c)
	--burst (gain skill)
	aux.EnableBurst(c)
	local e1=aux.AddActivateMainSkill(c,0,scard.op1,aux.BurstCost(3))
	e1:SetCountLimit(1)
end
scard.specified_cost={COLOR_RED,1}
scard.combo_cost=0
--burst (gain skill)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	--gain power
	aux.AddTempSkillUpdatePower(c,c,1,5000)
	--attack active
	aux.AddTempSkillCustom(c,c,2,EFFECT_ATTACK_ACTIVE_MODE)
end
