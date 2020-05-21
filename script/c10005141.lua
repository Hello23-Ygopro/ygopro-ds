--BT5-120 Miraculous Fighter SS3 Gogeta
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_GOGETA)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_SPECIAL)
	--battle card
	aux.EnableBattleAttribute(c)
	--ex-evolve
	aux.EnableEXEvolve(c,scard.evofilter,scard.cost1)
	--critical
	aux.EnableCritical(c)
	--union-fusion
	aux.EnableUnionFusion(c,scard.uniffilter1,scard.uniffilter2,aux.PaySkillCost(COLOR_BLUE,3,3))
	--ultimate
	aux.EnableUltimate(c)
	--deflect
	aux.EnableDeflect(c)
	--sparking (untap)
	aux.EnableSparking(c)
	aux.AddActivateMainSkill(c,0,scard.op1,scard.cost2,nil,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
scard.specified_cost={COLOR_BLUE,4}
scard.combo_cost=1
--ex-evolve
function scard.evofilter(c)
	return c:IsColor(COLOR_BLUE) and c:IsCharacter(CHARACTER_GOGETA) and c:IsEnergyAbove(7)
end
function scard.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
	local f=aux.HandFilter(Card.IsAbleToDrop)
	if chk==0 then return Duel.IsExistingMatchingCard(f,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	local g=Duel.GetMatchingGroup(f,tp,LOCATION_HAND,0,e:GetHandler())
	Duel.SendtoDrop(g,REASON_COST)
end
--union-fusion
scard.uniffilter1=aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_SON_GOKU)
scard.uniffilter2=aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_VEGETA)
--sparking (untap)
scard.con1=aux.AND(aux.SparkingCondition(15),aux.SelfRestCondition)
function scard.costfilter(c,charname)
	return c:IsCharacter(charname) and c:IsAbleToDeck()
end
function scard.cost2(e,tp,eg,ep,ev,re,r,rp,chk)
	local f1=aux.DropAreaFilter(scard.costfilter,CHARACTER_SON_GOKU)
	local f2=aux.DropAreaFilter(scard.costfilter,CHARACTER_VEGETA)
	if chk==0 then return Duel.IsExistingTarget(f1,tp,LOCATION_DROP,0,1,nil)
		and Duel.IsExistingTarget(f2,tp,LOCATION_DROP,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g1=Duel.SelectTarget(tp,f1,tp,LOCATION_DROP,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g2=Duel.SelectTarget(tp,f2,tp,LOCATION_DROP,0,1,1,nil)
	g1:Merge(g2)
	Duel.SendtoDeck(g1,PLAYER_OWNER,SEQ_DECK_BOTTOM,REASON_COST)
	Duel.ClearTargetCard()
end
scard.op1=aux.SelfSwitchtoActiveOperation
