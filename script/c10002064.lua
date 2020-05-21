--BT2-058 Infinite Force Fused Zamasu
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_ZAMASU)
	aux.AddSpecialTrait(c,TRAIT_GOD)
	aux.AddEra(c,ERA_FUTURE_TRUNKS_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--union-potara
	aux.EnableUnionPotara(c,scard.unipfilter1,scard.unipfilter2,aux.PaySkillCost(COLOR_BLUE,3,4))
	--indestructible
	aux.EnableIndestructible(c)
	--to deck
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
scard.specified_cost={COLOR_BLUE,4}
scard.combo_cost=1
--union-potara
scard.unipfilter1=aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_GOKU_BLACK)
scard.unipfilter2=aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_ZAMASU)
--to deck
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	Duel.SelectTarget(tp,aux.BattleAreaFilter(Card.IsAbleToDeck),tp,0,LOCATION_BATTLE,0,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	Duel.SelectTarget(tp,aux.EnergyAreaFilter(Card.IsAbleToDeck),tp,0,LOCATION_ENERGY,0,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	Duel.SelectTarget(tp,aux.LifeAreaFilter(Card.IsAbleToDeck),tp,0,LOCATION_LIFE,0,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	Duel.SelectTarget(tp,aux.HandFilter(Card.IsAbleToDeck),tp,0,LOCATION_HAND,0,1,nil)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if not g then return end
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	if sg:GetCount()>1 and Duel.SendtoDeck(sg,PLAYER_OWNER,SEQ_DECK_TOP,REASON_EFFECT)>0 then
		local dg1=Duel.GetOperatedGroup():Filter(Card.IsControler,nil,tp)
		local dg2=Duel.GetOperatedGroup():Filter(Card.IsControler,nil,1-tp)
		if dg1:GetCount()>0 then aux.SortDeck(tp,tp,dg1:GetCount(),SEQ_DECK_BOTTOM) end
		if dg2:GetCount()>0 then aux.SortDeck(tp,1-tp,dg2:GetCount(),SEQ_DECK_BOTTOM) end
	elseif sg:GetCount()==1 then
		Duel.SendtoDeck(sg,PLAYER_OWNER,SEQ_DECK_BOTTOM,REASON_EFFECT)
	end
end
