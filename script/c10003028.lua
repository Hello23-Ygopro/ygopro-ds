--BT3-027 Unending Awakening
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--extra card
	aux.EnableExtraAttribute(c)
	--negate attack, gain skill
	aux.AddCounterAttackSkill(c,0,scard.op1,nil,nil,EFFECT_FLAG_CARD_TARGET)
end
scard.specified_cost={COLOR_RED,1}
--negate attack, gain skill
function scard.powfilter(c,e)
	return c:IsFaceup() and c:IsColor(COLOR_RED) and c:IsSpecialTrait(TRAIT_SAIYAN) and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
	local tc=Duel.GetLeaderCard(tp)
	if not tc or not scard.powfilter(tc,e) then return end
	Duel.BreakEffect()
	Duel.SetTargetCard(tc)
	--gain power
	aux.AddTempSkillUpdatePower(e:GetHandler(),tc,1,5000)
end
