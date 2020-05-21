--BT3-122 Time's Judgement
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--extra card
	aux.EnableExtraAttribute(c)
	--negate attack, to hand
	aux.AddCounterAttackSkill(c,0,scard.op1)
end
--negate attack, to hand
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
	local g=Duel.GetMatchingGroup(aux.HandFilter(Card.IsAbleToDrop),tp,LOCATION_HAND,0,nil)
	if g:GetCount()<2 or not Duel.SelectYesNo(tp,YESNOMSG_DROP) then return end
	Duel.BreakEffect()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DROP)
	local sg=g:Select(tp,2,2,nil)
	if Duel.SendtoDrop(sg,REASON_EFFECT)==0 then return end
	local c=e:GetHandler()
	if Duel.SendtoHand(c,PLAYER_OWNER,REASON_EFFECT)>0 then
		Duel.ConfirmCards(1-tp,c)
	end
end
