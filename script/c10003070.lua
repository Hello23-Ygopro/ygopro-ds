--BT3-063_SPR Hyper Rush SSB Vegito (Alias)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_VEGITO)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_FUTURE_TRUNKS_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--union-potara
	aux.EnableUnionPotara(c,scard.unipfilter1,scard.unipfilter2,aux.PaySkillCost(COLOR_COLORLESS,0,5))
	--triple strike
	aux.EnableTripleStrike(c)
	--drop, draw, to hand
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
scard.specified_cost={COLOR_GREEN,2}
scard.combo_cost=1
--union-potara
scard.unipfilter1=aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_SON_GOKU)
scard.unipfilter2=aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_VEGETA)
--drop, draw, to hand
scard.con1=aux.SelfLeaderCondition(Card.IsCharacter,CHARACTER_VEGITO)
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DROP)
	Duel.SelectTarget(tp,aux.BattleAreaFilter(Card.IsAbleToDrop),tp,0,LOCATION_BATTLE,0,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DROP)
	Duel.SelectTarget(tp,aux.HandFilter(Card.IsAbleToDrop),tp,0,LOCATION_HAND,0,1,nil)
end
function scard.thfilter(c,e)
	return c:IsAbleToHand() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp,chk)
	local g1=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if g1 then
		local sg=g1:Filter(Card.IsRelateToEffect,nil,e)
		Duel.SendtoDrop(sg,REASON_EFFECT)
	end
	Duel.BreakEffect()
	Duel.Draw(tp,2,REASON_EFFECT)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g2=Duel.SelectMatchingCard(tp,aux.LifeAreaFilter(scard.thfilter),tp,LOCATION_LIFE,0,0,2,nil,e)
	if g2:GetCount()==0 then return end
	Duel.BreakEffect()
	Duel.SetTargetCard(g2)
	Duel.SendtoHand(g2,PLAYER_OWNER,REASON_EFFECT)
end
