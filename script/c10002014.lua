--BT2-012 Repeated Force Vegito
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_VEGITO)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_MAJIN_BUU_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--union-potara
	aux.EnableUnionPotara(c,scard.unipfilter1,scard.unipfilter2,aux.PaySkillCost(COLOR_COLORLESS,0,5))
	--triple strike
	aux.EnableTripleStrike(c)
	--gain skill
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.op1)
end
scard.specified_cost={COLOR_RED,1}
scard.combo_cost=1
--union-potara
scard.unipfilter1=aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_SON_GOKU)
scard.unipfilter2=aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_VEGETA)
--gain skill
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	--gain power
	aux.AddTempSkillUpdatePower(c,c,1,scard.val1)
end
function scard.val1(e,c)
	local tp=c:GetControler()
	local ct1=Duel.GetMatchingGroupCount(aux.DropAreaFilter(Card.IsCharacter,CHARACTER_SON_GOKU),tp,LOCATION_DROP,0,nil)*5000
	local ct2=Duel.GetMatchingGroupCount(aux.DropAreaFilter(Card.IsCharacter,CHARACTER_VEGETA),tp,LOCATION_DROP,0,nil)*5000
	return ct1+ct2
end
