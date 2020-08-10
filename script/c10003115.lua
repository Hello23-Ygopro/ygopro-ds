--BT3-105 Planet Vegeta
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,1)
	--extra card
	aux.EnableExtraAttribute(c)
	--field
	aux.EnableField(c)
	--untap
	aux.AddAutoSkill(c,0,EVENT_PHASE+PHASE_END,nil,scard.op1,nil,scard.con1)
	--search (to hand)
	local e1=aux.AddSingleAutoSkill(c,1,EVENT_CUSTOM+EVENT_MOVE_EXTRA_CARD,scard.tg1,scard.op2,EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_FIELD)
end
--untap
function scard.untfilter(c)
	return c:IsSpecialTrait(TRAIT_GREAT_APE) and c:IsAbleToSwitchToActive()
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
		and Duel.IsExistingMatchingCard(aux.BattleAreaFilter(scard.untfilter),tp,LOCATION_BATTLE,0,1,nil)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=Duel.GetMatchingGroup(aux.BattleAreaFilter(scard.untfilter),tp,LOCATION_BATTLE,0,nil)
	Duel.SwitchtoActive(g,REASON_EFFECT)
end
--search (to hand)
function scard.thfilter(c)
	return c:IsSpecialTrait(TRAIT_SAIYAN) and c:IsEnergyBelow(4) and c:IsAbleToHand()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.thfilter,LOCATION_DECK,0,0,1,HINTMSG_ATOHAND)
scard.op2=aux.TargetSendtoHandOperation(true)
