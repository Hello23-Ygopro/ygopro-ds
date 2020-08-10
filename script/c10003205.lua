--TB1-049 Shining Blaster
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,1)
	--extra card
	aux.EnableExtraAttribute(c)
	--negate attack, return
	aux.AddCounterAttackSkill(c,0,scard.op1,nil,nil,EFFECT_FLAG_CARD_TARGET)
end
--negate attack, return
function scard.thfilter(c,e)
	return c:IsEnergyBelow(4) and c:IsAbleToHand() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
	if not aux.SelfLeaderCondition(Card.IsSpecialTrait,TRAIT_UNIVERSE_9)(e,tp,eg,ep,ev,re,r,rp) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectMatchingCard(tp,aux.BattleAreaFilter(scard.thfilter),tp,0,LOCATION_BATTLE,0,1,nil,e)
	if g:GetCount()==0 then return end
	Duel.BreakEffect()
	Duel.SetTargetCard(g)
	Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
end
