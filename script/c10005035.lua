--BT5-030 Resolute Strength Son Goku
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_SON_GOKU)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_JANEMBA_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOKU)
	--battle card
	aux.EnableBattleAttribute(c)
	--evolve
	aux.EnableEvolve(c,scard.evofilter,aux.PaySkillCost(COLOR_BLUE,1,0))
	--barrier
	aux.EnableBarrier(c)
	--burst (drop, to deck, play)
	aux.EnableBurst(c)
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_IGNORE_BARRIER,aux.EvolvePlayCondition,aux.BurstCost(5))
end
scard.specified_cost={COLOR_BLUE,2}
scard.combo_cost=0
--evolve
function scard.evofilter(c)
	return aux.IsCode(c,CARD_SUPER_SAIYAN_SON_GOKU) and c:IsColor(COLOR_BLUE) and c:IsEnergyAbove(2)
end
--burst (drop, to deck, play)
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.LifeAreaFilter(Card.IsAbleToDrop),LOCATION_LIFE,0,1,1,HINTMSG_DROP)
function scard.playfilter(c,e,tp)
	return c:IsCode(CARD_DEADLY_DEFENDER_VEGETA) and c:IsCanBePlayed(e,0,tp,false,false) and c:IsCanBeEffectTarget(e)
end
function scard.tdfilter(c,e)
	return c:IsEnergyBelow(2) and c:IsAbleToDeck() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SendtoDrop(tc,REASON_EFFECT)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g1=Duel.SelectMatchingCard(tp,aux.BattleAreaFilter(scard.tdfilter),tp,0,LOCATION_BATTLE,0,1,nil,e)
	if g1:GetCount()>0 then
		Duel.BreakEffect()
		Duel.SetTargetCard(g1)
		Duel.SendtoDeck(g1,PLAYER_OWNER,SEQ_DECK_BOTTOM,REASON_EFFECT)
	end
	local g2=Duel.GetMatchingGroup(scard.playfilter,tp,LOCATION_DECK,0,nil,e,tp)
	local g3=Duel.GetMatchingGroup(aux.DropAreaFilter(scard.playfilter),tp,LOCATION_DROP,0,nil,e,tp)
	g2:Merge(g3)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_PLAY)
	local sg=g2:Select(tp,0,1,nil)
	if sg:GetCount()==0 then return end
	Duel.BreakEffect()
	Duel.SetTargetCard(sg)
	Duel.Play(sg,0,tp,tp,false,false,POS_FACEUP_ACTIVE)
end
