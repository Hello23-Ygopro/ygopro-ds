--P-083 Dangerous Journey Bulma
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_BULMA)
	aux.AddSpecialTrait(c,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_PILAF_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--to deck, draw
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
scard.combo_cost=0
--to deck, draw
scard.con1=aux.SelfLeaderCondition(Card.IsSpecialTrait,TRAIT_SHENRON)
function scard.tdfilter(c)
	return c:IsBattle() and c:IsEnergyAbove(3) and c:IsAbleToDeck()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.DropAreaFilter(scard.tdfilter),LOCATION_DROP,0,0,3,HINTMSG_TODECK)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if not g then return end
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	if Duel.SendtoDeck(sg,PLAYER_OWNER,SEQ_DECK_SHUFFLE,REASON_EFFECT)==0 then return end
	if not Duel.GetOperatedGroup():IsExists(Card.IsLocation,1,nil,LOCATION_DECK) then return end
	Duel.ShuffleDeck(tp)
	Duel.BreakEffect()
	Duel.Draw(tp,1,REASON_EFFECT)
end
