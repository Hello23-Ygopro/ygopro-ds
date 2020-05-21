--BT5-037 Vexing Outcome Veku
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_VEKU)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_JANEMBA_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--union-fusion
	aux.EnableUnionFusion(c,scard.uniffilter1,scard.uniffilter2,aux.PaySkillCost(COLOR_BLUE,1,0))
	--search (to hand, draw)
	aux.AddActivateMainSkill(c,0,scard.op1,aux.SelfDropCost,scard.tg1,EFFECT_FLAG_CARD_TARGET)
end
scard.specified_cost={COLOR_BLUE,1}
scard.combo_cost=1
--union-fusion
scard.uniffilter1=aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_SON_GOKU)
scard.uniffilter2=aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_VEGETA)
--search (to hand, draw)
function scard.thfilter(c,cardname)
	return aux.IsCode(c,cardname) and c:IsColor(COLOR_BLUE) and c:IsEnergy(2) and c:IsAbleToHand()
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	Duel.SelectTarget(tp,scard.thfilter,tp,LOCATION_DECK,0,0,1,nil,CARD_SUPER_SAIYAN_SON_GOKU)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	Duel.SelectTarget(tp,scard.thfilter,tp,LOCATION_DECK,0,0,1,nil,CARD_SUPER_SAIYAN_VEGETA)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if g then
		local sg=g:Filter(Card.IsRelateToEffect,nil,e)
		Duel.SendtoHand(sg,PLAYER_OWNER,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
	end
	if e:GetHandler():GetSummonType()==SUMMON_TYPE_UNION then
		Duel.BreakEffect()
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
