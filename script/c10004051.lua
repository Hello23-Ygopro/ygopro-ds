--BT4-046 Piccolo, Kami's Successor
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_PICCOLO)
	aux.AddSpecialTrait(c,TRAIT_NAMEKIAN,TRAIT_GOD,TRAIT_UNIVERSE_7)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,TRAIT_CATEGORY_UNIVERSE)
	--leader card
	aux.EnableLeaderAttribute(c)
	--bond (critical)
	aux.EnableBond(c)
	aux.EnableCritical(c,aux.BondCondition(2,Card.IsSpecialTrait,TRAIT_NAMEKIAN))
	--draw, gain skill
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.op1)
end
scard.front_side_code=sid-1
--draw, gain skill
function scard.powfilter(c,e)
	return c:IsSpecialTrait(TRAIT_NAMEKIAN) and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectMatchingCard(tp,aux.BattleAreaFilter(scard.powfilter),tp,LOCATION_BATTLE,0,0,1,nil,e)
	if g:GetCount()==0 then return end
	Duel.BreakEffect()
	Duel.SetTargetCard(g)
	--gain power
	aux.AddTempSkillUpdatePower(e:GetHandler(),g:GetFirst(),1,5000)
end
