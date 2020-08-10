--BT2-065 Time Ring
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,1)
	--extra card
	aux.EnableExtraAttribute(c)
	--to hand
	aux.AddActivateMainSkill(c,0,scard.op1,nil,scard.tg1,EFFECT_FLAG_CARD_TARGET)
end
--to hand
function scard.thfilter1(c)
	return c:IsCharacter(CHARACTER_GOKU_BLACK,CHARACTER_ZAMASU) and c:IsAbleToHand()
end
function scard.thfilter2(c,e)
	return scard.thfilter1(c) and c:IsCanBeEffectTarget(e)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_DECK) and chkc:IsControler(tp) and scard.thfilter1(chkc) end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	local g=Duel.GetDecktopGroup(tp,10)
	Duel.ConfirmCards(tp,g)
	local ct=(Duel.GetEnergyCount(tp)>=4 and 2 or 1)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local sg=g:FilterSelect(tp,scard.thfilter2,0,ct,nil,e)
	Duel.SetTargetCard(sg)
end
scard.op1=aux.TargetDecktopSendtoHandOperation(10,SEQ_DECK_SHUFFLE,true)
