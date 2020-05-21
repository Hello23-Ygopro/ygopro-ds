--BT2-067 Zen-Oh Button
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--extra card
	aux.EnableExtraAttribute(c)
	--untap
	aux.AddCounterAttackSkill(c,0,scard.op1)
end
--untap
function scard.untfilter(c)
	return c:IsColor(COLOR_BLUE) and c:IsAbleToSwitchToActive()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(aux.EnergyAreaFilter(scard.untfilter),tp,LOCATION_ENERGY,0,nil)
	Duel.SwitchtoActive(g,REASON_EFFECT)
end
