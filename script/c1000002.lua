--P-002 Proud Spark Vados
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_VADOS)
	aux.AddSpecialTrait(c,TRAIT_GOD)
	aux.AddEra(c,ERA_CHAMPA_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--double strike
	aux.EnableDoubleStrike(c)
	--gain skill
	aux.AddAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.op1,nil,scard.con1)
end
scard.specified_cost={COLOR_RED,2}
scard.combo_cost=1
--gain skill
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	return a and a:IsLeader() and a:IsControler(tp) and d and d:IsFaceup() and d:IsBattle()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if c:IsRelateToEffect(e) and a:IsFaceup() then
		--gain power
		aux.AddTempSkillUpdatePower(c,a,1,5000)
	end
	if c:IsRelateToEffect(e) and d:IsFaceup() then
		--gain power
		aux.AddTempSkillUpdatePower(c,d,1,5000)
	end
end
