--BT4-072 Legacy Bearer Son Goku
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_SON_GOKU)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_GOKUS_LINEAGE)
	aux.AddEra(c,ERA_MAJIN_BUU_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOKU)
	--leader card
	aux.EnableLeaderAttribute(c)
	--draw, gain skill
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
scard.front_side_code=sid-1
--draw, gain skill
function scard.powfilter(c,e)
	return c:IsSpecialTrait(TRAIT_GOKUS_LINEAGE) and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local tc=Duel.SelectMatchingCard(tp,aux.BattleAreaFilter(scard.powfilter),tp,LOCATION_BATTLE,0,0,1,nil,e):GetFirst()
	if tc then
		Duel.BreakEffect()
		Duel.SetTargetCard(tc)
	end
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		--gain power
		aux.AddTempSkillUpdatePower(c,c,1,5000)
	end
	if tc and tc:IsRelateToEffect(e) then
		--gain power
		aux.AddTempSkillUpdatePower(c,tc,1,5000)
	end
end
