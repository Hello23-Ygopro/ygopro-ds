--BT5-025 A King's Return to Youth
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_RED,1)
	--extra card
	aux.EnableExtraAttribute(c)
	--add special trait
	aux.AddPermanentAddSpecialTrait(c,TRAIT_DESIRE)
	--search (to hand)
	aux.AddActivateMainSkill(c,0,scard.op1,nil,scard.tg1,EFFECT_FLAG_CARD_TARGET,aux.SelfLeaderCondition(scard.lfilter))
end
--search (to hand)
function scard.lfilter(c)
	return c:IsColor(COLOR_RED) and c:IsSpecialTrait(TRAIT_SHENRON)
end
function scard.thfilter(c,code)
	return c:IsCode(code) and c:IsAbleToHand()
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	Duel.SelectTarget(tp,scard.thfilter,tp,LOCATION_DECK,0,0,1,nil,CARD_KING_PICCOLO_TERROR_UNLEASHED)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	Duel.SelectTarget(tp,scard.thfilter,tp,LOCATION_DECK,0,0,1,nil,CARD_A_KINGS_RETURN_TO_YOUTH)
end
scard.op1=aux.TargetSendtoHandOperation(true)
