--BT1-003 Assassin Hit
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_HIT)
	aux.AddSpecialTrait(c,TRAIT_ALIEN)
	aux.AddEra(c,ERA_CHAMPA_SAGA)
	--leader card
	aux.EnableLeaderAttribute(c)
	--draw, gain skill
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.op1)
	--drop, negate skill
	local e1=aux.AddAutoSkill(c,1,EVENT_CHAINING,nil,scard.op2,nil,scard.con1)
	e1:SetCountLimit(1)
end
scard.front_side_code=sid-1
--draw, gain skill
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	--gain power
	aux.AddTempSkillUpdatePower(c,c,2,5000)
end
--drop, negate skill
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return rp==1-tp and re:IsHasCategory(CATEGORY_BLOCKER) and Duel.IsChainDisablable(ev)
end
function scard.dropfilter(c)
	return c:IsColor(COLOR_RED) and c:IsAbleToDrop()
end
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DROP)
	local g=Duel.SelectMatchingCard(tp,aux.HandFilter(scard.dropfilter),tp,LOCATION_HAND,0,0,1,nil)
	if g:GetCount()==0 or Duel.SendtoDrop(g,REASON_EFFECT)==0 then return end
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.NegateEffect(ev)
	end
end
