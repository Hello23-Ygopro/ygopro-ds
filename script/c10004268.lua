--TB2-064 I'm the World Champion!
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,1)
	--extra card
	aux.EnableExtraAttribute(c)
	--draw
	aux.AddActivateMainSkill(c,0,scard.op1)
end
--draw
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsExistingMatchingCard(aux.BattleAreaFilter(Card.IsCharacter,CHARACTER_SON_GOKU_CHILDHOOD),tp,LOCATION_BATTLE,0,1,nil) then
		Duel.Draw(tp,2,REASON_EFFECT)
	end
end
