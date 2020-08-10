--EX01-04 SSB Vegito, the Savior
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,3)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_VEGITO)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_FUTURE_TRUNKS_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--union-potara
	aux.EnableUnionPotara(c,scard.unipfilter1,scard.unipfilter2,aux.PaySkillCost(COLOR_BLUE,2,3))
	--dual attack
	aux.EnableDualAttack(c)
	--critical
	aux.EnableCritical(c)
	--gain skill
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.op1,nil,scard.con1)
end
--union-potara
scard.unipfilter1=aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_SON_GOKU)
scard.unipfilter2=aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_VEGETA)
--gain skill
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetAttackAnnouncedCount()==2
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	--double strike
	aux.AddTempSkillCustom(c,c,1,EFFECT_DOUBLE_STRIKE)
end
