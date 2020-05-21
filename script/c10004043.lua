--BT4-039 Oath's Power, Tapion
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_TAPION)
	aux.AddSpecialTrait(c,TRAIT_HERO)
	aux.AddEra(c,ERA_HIRUDEGARN_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--to hand, to deck
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
scard.specified_cost={COLOR_BLUE,2}
scard.combo_cost=0
--to hand, to deck
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.LifeAreaFilter(Card.IsAbleToHand),LOCATION_LIFE,0,0,2,HINTMSG_ATOHAND)
function scard.tdfilter(c,e)
	return c:IsEnergyBelow(5) and c:IsAbleToDeck() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if not g1 then return end
	local sg=g1:Filter(Card.IsRelateToEffect,nil,e)
	if Duel.SendtoHand(sg,PLAYER_OWNER,REASON_EFFECT)==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g2=Duel.SelectMatchingCard(tp,aux.BattleAreaFilter(scard.tdfilter),tp,0,LOCATION_BATTLE,0,1,nil,e)
	if g2:GetCount()==0 then return end
	Duel.BreakEffect()
	Duel.SetTargetCard(g2)
	Duel.SendtoDeck(g2,PLAYER_OWNER,SEQ_DECK_TOP,REASON_EFFECT)
end
