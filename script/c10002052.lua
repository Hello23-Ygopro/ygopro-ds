--BT2-046 Beerus, Essence of Destruction
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_BEERUS)
	aux.AddSpecialTrait(c,TRAIT_GOD)
	aux.AddEra(c,ERA_FUTURE_TRUNKS_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--double strike
	aux.EnableDoubleStrike(c)
	--to deck, return
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
scard.specified_cost={COLOR_BLUE,2}
scard.combo_cost=1
--to deck, return
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local f=aux.HandFilter(Card.IsAbleToDeck)
	if chkc then return chkc:IsLocation(LOCATION_HAND) and chkc:IsControler(1-tp) and f(chkc) end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	local ct=Duel.GetMatchingGroupCount(aux.BattleAreaFilter(Card.IsEnergyBelow,1),tp,0,LOCATION_BATTLE,nil)
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_TODECK)
	Duel.SelectTarget(1-tp,f,1-tp,LOCATION_HAND,0,ct,ct,nil)
end
function scard.thfilter(c)
	return c:IsEnergyBelow(1) and c:IsAbleToHand()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if g1 then
		local sg=g1:Filter(Card.IsRelateToEffect,nil,e)
		Duel.SendtoDeck(sg,PLAYER_OWNER,SEQ_DECK_TOP,REASON_EFFECT)
		local ct=Duel.GetOperatedGroup():GetCount()
		if ct>1 then
			Duel.SortDecktop(1-tp,1-tp,ct)
		end
	end
	local g2=Duel.GetMatchingGroup(aux.BattleAreaFilter(scard.thfilter),tp,0,LOCATION_BATTLE,nil)
	Duel.BreakEffect()
	Duel.SendtoHand(g2,PLAYER_OWNER,REASON_EFFECT)
end
