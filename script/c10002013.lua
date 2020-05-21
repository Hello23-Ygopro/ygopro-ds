--BT2-011 Leap to The Future Trunks
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_TRUNKS_YOUTH)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_THE_EVIL_WIZARD_BABIDI_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--search (to hand)
	local e1=aux.AddActivateMainSkill(c,0,scard.op1,scard.cost1,scard.tg1,EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_HAND)
end
scard.specified_cost={COLOR_RED,1}
scard.combo_cost=0
--search (to hand)
function scard.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local f=aux.HandFilter(Card.IsAbleToDrop)
	if chk==0 then return c:IsAbleToDrop() and Duel.IsExistingMatchingCard(f,tp,LOCATION_HAND,0,1,c) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DROP)
	local g=Duel.SelectMatchingCard(tp,f,tp,LOCATION_HAND,0,1,1,c)
	g:AddCard(c)
	Duel.SendtoDrop(g,REASON_COST)
end
function scard.thfilter(c)
	return c:IsCharacter(CHARACTER_GOTENKS) and c:IsPowerBelow(25000) and c:IsAbleToHand()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.thfilter,LOCATION_DECK,0,0,1,HINTMSG_ATOHAND)
scard.op1=aux.TargetSendtoHandOperation(true)
