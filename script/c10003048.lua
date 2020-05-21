--BT3-044 Thinks He's the Best Hercule
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_HERCULE)
	aux.AddSpecialTrait(c,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_MAJIN_BUU_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--to deck, charge
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
scard.specified_cost={COLOR_BLUE,1}
scard.combo_cost=0
--to deck, charge
scard.con1=aux.SelfLeaderCondition(Card.IsCharacter,CHARACTER_MAJIN_BUU)
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.EnergyAreaFilter(Card.IsAbleToDeck),LOCATION_ENERGY,0,2,2,HINTMSG_TODECK)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if g then
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
	Duel.BreakEffect()
	Duel.SendDecktoptoEnergy(tp,2,REASON_EFFECT)
end
