--BT1-025 Vados's Assistance
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--extra card
	aux.EnableExtraAttribute(c)
	--negate attack, untap
	aux.AddCounterAttackSkill(c,0,scard.op1)
end
scard.specified_cost={COLOR_RED,1}
--negate attack, untap
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOACTIVE)
	local g=Duel.SelectMatchingCard(tp,aux.BattleAreaFilter(Card.IsAbleToSwitchToActive),tp,LOCATION_BATTLE,0,0,1,nil)
	if g:GetCount()==0 then return end
	Duel.BreakEffect()
	Duel.HintSelection(g)
	Duel.SwitchtoActive(g,REASON_EFFECT)
end
