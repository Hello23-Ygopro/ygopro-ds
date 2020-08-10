--TB2-025 Begrudging Respect Vegeta
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_VEGETA)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_WORLD_TOURNAMENT)
	aux.AddEra(c,ERA_MAJIN_BUU_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--barrier
	aux.EnableBarrier(c)
	--to deck
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
--to deck
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return aux.SelfLeaderCondition(Card.IsSpecialTrait,TRAIT_WORLD_TOURNAMENT)(e,tp,eg,ep,ev,re,r,rp)
		and Duel.IsExistingMatchingCard(aux.BattleAreaFilter(Card.IsCode,CARD_BEGRUDGING_RESPECT_PICCOLO),tp,LOCATION_BATTLE,0,1,nil)
end
scard.tg1=aux.TargetCardFunction(PLAYER_OPPO,aux.HandFilter(Card.IsAbleToDeck),0,LOCATION_HAND,2,2,HINTMSG_TODECK)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if not g then return end
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	if Duel.SendtoDeck(sg,PLAYER_OWNER,SEQ_DECK_TOP,REASON_EFFECT)==0 then return end
	local dg1=Duel.GetOperatedGroup():Filter(Card.IsControler,nil,tp)
	local dg2=Duel.GetOperatedGroup():Filter(Card.IsControler,nil,1-tp)
	if dg1:GetCount()>1 then Duel.SortDecktop(1-tp,tp,dg1:GetCount()) end
	if dg2:GetCount()>1 then Duel.SortDecktop(1-tp,1-tp,dg2:GetCount()) end
end
