--BT4-019 Saiyan Onslaught Kefla
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_RED,2)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_KEFLA)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_ALIEN,TRAIT_UNIVERSE_6)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,TRAIT_CATEGORY_UNIVERSE)
	--battle card
	aux.EnableBattleAttribute(c)
	--union-potara
	aux.EnableUnionPotara(c,scard.unipfilter1,scard.unipfilter2,aux.PaySkillCost(COLOR_RED,3,0))
	--deflect
	aux.EnableDeflect(c)
	--dual attack
	aux.EnableDualAttack(c)
	--draw, gain skill
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,nil,scard.op1,nil,aux.UnionPotaraPlayCondition)
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.op1)
end
--union-potara
scard.unipfilter1=aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_CAULIFLA)
scard.unipfilter2=aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_KALE)
--draw, gain skill
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	--gain power
	aux.AddTempSkillUpdatePower(c,c,1,5000)
end
