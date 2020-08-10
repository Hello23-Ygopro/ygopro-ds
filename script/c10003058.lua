--BT3-054 Buu Make You Cookie
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,1)
	--extra card
	aux.EnableExtraAttribute(c)
	--negate attack, absorb
	aux.AddCounterAttackSkill(c,0,scard.op1,nil,nil,EFFECT_FLAG_CARD_TARGET)
end
--negate attack, absorb
function scard.abfilter1(c,e)
	return c:IsCharacter(CHARACTER_MAJIN_BUU) and c:IsCanBeEffectTarget(e)
end
function scard.abfilter2(c,e)
	return c:IsEnergyBelow(3) and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
	local g1=Duel.GetMatchingGroup(aux.HandFilter(Card.IsAbleToDrop),tp,LOCATION_HAND,0,e:GetHandler())
	if not aux.SelfLeaderCondition(Card.IsCharacter,CHARACTER_MAJIN_BUU)(e,tp,eg,ep,ev,re,r,rp)
		or g1:GetCount()==0 or not Duel.SelectYesNo(tp,YESNOMSG_DROP) then return end
	Duel.BreakEffect()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DROP)
	local sg=g1:Select(tp,1,1,nil)
	if Duel.SendtoDrop(sg,REASON_EFFECT)==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local tc1=Duel.SelectMatchingCard(tp,aux.FaceupFilter(scard.abfilter1,e),tp,LOCATION_INPLAY,0,1,1,nil,e):GetFirst()
	if tc1 then Duel.SetTargetCard(tc1) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ABSORB)
	local tc2=Duel.SelectMatchingCard(tp,aux.BattleAreaFilter(scard.abfilter2),tp,0,LOCATION_BATTLE,1,1,nil,e):GetFirst()
	if tc2 then Duel.SetTargetCard(tc2) end
	if tc1 and tc2 then
		Duel.PlaceUnder(tc1,tc2)
	end
end
