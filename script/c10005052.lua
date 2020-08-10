--BT5-045 King Yemma, Soul Supervisor
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_KING_YEMMA)
	aux.AddSpecialTrait(c,TRAIT_GOD)
	aux.AddEra(c,ERA_JANEMBA_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--to deck, draw
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--to deck, draw
function scard.tdfilter(c)
	return c:IsBattle() and not c:IsColor(COLOR_BLACK) and c:IsAbleToDeck()
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local f=aux.DropAreaFilter(scard.tdfilter)
	if chkc then return chkc:IsLocation(LOCATION_DROP) and chkc:IsControler(1-tp) and f(chkc) end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	if not Duel.IsExistingTarget(f,tp,0,LOCATION_DROP,2,nil) or not Duel.SelectYesNo(tp,YESNOMSG_TODECK) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	Duel.SelectTarget(tp,f,tp,0,LOCATION_DROP,2,2,nil)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if not g then return end
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	if sg:GetCount()>1 and Duel.SendtoDeck(sg,PLAYER_OWNER,SEQ_DECK_TOP,REASON_EFFECT)>0 then
		local dg1=sg:Filter(Card.IsControler,nil,tp)
		local dg2=sg:Filter(Card.IsControler,nil,1-tp)
		if dg1:GetCount()>0 then aux.SortDeck(tp,tp,dg1:GetCount(),SEQ_DECK_BOTTOM) end
		if dg2:GetCount()>0 then aux.SortDeck(tp,1-tp,dg2:GetCount(),SEQ_DECK_BOTTOM) end
		Duel.Draw(tp,1,REASON_EFFECT)
	elseif sg:GetCount()==1 and Duel.SendtoDeck(sg,PLAYER_OWNER,SEQ_DECK_BOTTOM,REASON_EFFECT)>0 then
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
