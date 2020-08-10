--BT1-110 Crusher Ball
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,1)
	--extra card
	aux.EnableExtraAttribute(c)
	--tap
	aux.AddCounterPlaySkill(c,0,scard.op1,nil,scard.tg1)
end
--tap
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=eg:Filter(aux.BattleAreaFilter(Card.IsActive),nil)
	if chk==0 then return g:GetCount()>0 end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.SetTargetCard(g)
end
scard.op1=aux.TargetCardsOperation(Duel.SwitchtoRest,REASON_EFFECT)
