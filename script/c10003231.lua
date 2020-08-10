--TB1-072 Maiden Charge
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,1)
	--extra card
	aux.EnableExtraAttribute(c)
	--negate attack, drop, ko
	aux.AddCounterAttackSkill(c,0,scard.op1,nil,nil,EFFECT_FLAG_CARD_TARGET)
end
--negate attack, drop, ko
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
	local g1=Duel.GetMatchingGroup(aux.HandFilter(Card.IsAbleToDrop),tp,LOCATION_HAND,0,nil)
	if not aux.SelfLeaderCondition(Card.IsSpecialTrait,TRAIT_UNIVERSE_2)(e,tp,eg,ep,ev,re,r,rp)
		or g1:GetCount()==0 or not Duel.SelectYesNo(tp,YESNOMSG_DROP) then return end
	Duel.BreakEffect()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DROP)
	local sg=g1:Select(tp,1,1,nil)
	if Duel.SendtoDrop(sg,REASON_EFFECT)==0 then return end
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_KO)
	local g2=Duel.SelectMatchingCard(1-tp,aux.BattleAreaFilter(Card.IsCanBeEffectTarget),1-tp,LOCATION_BATTLE,0,1,1,nil,e)
	if g2:GetCount()==0 then return end
	Duel.SetTargetCard(g2)
	Duel.KO(g2,REASON_EFFECT)
end
