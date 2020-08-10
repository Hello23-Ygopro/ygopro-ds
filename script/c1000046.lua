--P-042 Great Ape Prince Vegeta
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,2)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_VEGETA)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_GREAT_APE)
	aux.AddEra(c,ERA_SAIYAN_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--critical
	aux.EnableCritical(c)
	--blocker
	aux.EnableBlocker(c)
	--to hand, drop
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
	aux.AddSingleAutoSkill(c,0,EVENT_CUSTOM+EVENT_COMBO,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--to hand, drop
function scard.thfilter(c)
	return c:IsSpecialTrait(TRAIT_GREAT_APE) and c:IsAbleToHand()
end
scard.tg1=aux.TargetDecktopTarget(scard.thfilter,3,0,1,HINTMSG_ATOHAND)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,PLAYER_OWNER,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
		Duel.ShuffleHand(tp)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DROP)
		local g=Duel.SelectMatchingCard(tp,aux.HandFilter(Card.IsAbleToDrop),tp,LOCATION_HAND,0,1,1,nil)
		if g:GetCount()==0 then return end
		Duel.SendtoDrop(g,REASON_EFFECT)
	end
	Duel.ShuffleDeck(tp)
end
