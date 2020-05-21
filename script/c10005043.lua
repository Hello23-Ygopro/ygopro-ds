--BT5-038 Gogeta, Hero Revived
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_GOGETA)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_JANEMBA_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--triple strike
	aux.EnableTripleStrike(c)
	--union-fusion
	aux.EnableUnionFusion(c,scard.uniffilter1,scard.uniffilter2,aux.PaySkillCost(COLOR_BLUE,2,3))
	--barrier
	aux.EnableBarrier(c)
	--deflect
	aux.EnableDeflect(c)
	--sparking (drop, to deck, draw)
	aux.EnableSparking(c)
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,aux.SparkingCondition(10))
end
scard.specified_cost={COLOR_BLUE,4}
scard.combo_cost=1
--union-fusion
scard.uniffilter1=aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_SON_GOKU)
scard.uniffilter2=aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_VEGETA)
--sparking (drop, to deck, draw)
scard.con1=aux.EnergyEqualAboveCondition(PLAYER_SELF,5)
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.LifeAreaFilter(Card.IsAbleToDrop),LOCATION_LIFE,0,1,1,HINTMSG_DROP,scard.con1)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SendtoDrop(tc,REASON_EFFECT)
	end
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	Duel.SendtoDeck(g,PLAYER_OWNER,SEQ_DECK_SHUFFLE,REASON_EFFECT)
	Duel.ShuffleDeck(1-tp)
	Duel.BreakEffect()
	Duel.Draw(1-tp,3,REASON_EFFECT)
end
