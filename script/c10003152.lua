--TB1-001 Saiyan Bond Vegeta
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_VEGETA)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_UNIVERSE_7)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,TRAIT_CATEGORY_UNIVERSE)
	--leader card
	aux.EnableLeaderAttribute(c)
	--warrior of universe 7
	aux.EnableWarriorofUniverse7(c)
	--draw, gain skill
	local e1=aux.AddAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
	e1:SetCountLimit(1)
end
scard.front_side_code=sid-1
--draw, gain skill
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	return tc and tc:IsControler(tp) and tc:IsBattle() and tc:IsSpecialTrait(TRAIT_SAIYAN)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetAttacker()
	if not c:IsRelateToEffect(e) then return end
	if not scard.con1(e,tp,eg,ep,ev,re,r,rp) or not tc:IsSpecialTrait(TRAIT_UNIVERSE_7,TRAIT_UNIVERSE_6) then return end
	Duel.Draw(tp,1,REASON_EFFECT)
	if tc:IsCanBeEffectTarget(e) then
		Duel.SetTargetCard(tc)
		--gain power
		aux.AddTempSkillUpdatePower(c,tc,1,5000)
	end
	--gain power
	aux.AddTempSkillUpdatePower(c,c,1,5000)
end
