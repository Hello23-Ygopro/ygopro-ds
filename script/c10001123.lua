--BT1-108 Bad Ring Laser
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--extra card
	aux.EnableExtraAttribute(c)
	--negate skill
	aux.AddCounterCounterSkill(c,0,scard.op1,aux.DropCost(aux.HandFilter(Card.IsColor,COLOR_YELLOW),LOCATION_HAND,0,1))
end
scard.specified_cost={COLOR_YELLOW,1}
--negate skill
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateEffect(ev)
end
