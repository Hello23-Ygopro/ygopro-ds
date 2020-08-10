--SD6-04 Ultimate Fusion Gogeta
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,2)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_GOGETA)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_JANEMBA_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--double strike
	aux.EnableDoubleStrike(c)
	--union-fusion
	aux.EnableUnionFusion(c,scard.uniffilter1,scard.uniffilter2,aux.PaySkillCost(COLOR_BLUE,2,2))
	--sparking (draw, to deck)
	aux.EnableSparking(c)
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,nil,scard.op1,EFFECT_FLAG_CARD_TARGET,aux.SparkingCondition(5))
end
--union-fusion
scard.uniffilter1=aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_SON_GOKU)
scard.uniffilter2=aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_VEGETA)
--sparking (draw, to deck)
function scard.tdfilter(c,e)
	return c:IsAbleToDeck() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,2,REASON_EFFECT)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,aux.BattleAreaFilter(scard.tdfilter),tp,0,LOCATION_BATTLE,0,2,nil,e)
	if g:GetCount()==0 then return end
	Duel.BreakEffect()
	Duel.SetTargetCard(g)
	if g:GetCount()>1 and Duel.SendtoDeck(g,PLAYER_OWNER,SEQ_DECK_TOP,REASON_EFFECT)>0 then
		local dg1=g:Filter(Card.IsControler,nil,tp)
		local dg2=g:Filter(Card.IsControler,nil,1-tp)
		if dg1:GetCount()>0 then aux.SortDeck(tp,tp,dg1:GetCount(),SEQ_DECK_BOTTOM) end
		if dg2:GetCount()>0 then aux.SortDeck(tp,1-tp,dg2:GetCount(),SEQ_DECK_BOTTOM) end
	elseif g:GetCount()==1 then
		Duel.SendtoDeck(g,PLAYER_OWNER,SEQ_DECK_BOTTOM,REASON_EFFECT)
	end
end
