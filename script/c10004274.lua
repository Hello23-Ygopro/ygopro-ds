--TB2-069 Son Goku & Uub, Seeds of the Future
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,3)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_SON_GOKU,CHARACTER_UUB)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_EARTHLING,TRAIT_WORLD_TOURNAMENT)
	aux.AddEra(c,ERA_MAJIN_BUU_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOKU)
	--battle card
	aux.EnableBattleAttribute(c)
	--double strike
	aux.EnableDoubleStrike(c)
	--dual attack
	aux.EnableDualAttack(c)
	--ultimate
	aux.EnableUltimate(c)
	--reduce energy cost
	aux.AddPermanentUpdateEnergyCost(c,-2,nil,scard.con1)
	--to deck
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--reduce energy cost
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local tp=e:GetHandlerPlayer()
	return aux.SelfLeaderCondition(Card.IsSpecialTrait,TRAIT_WORLD_TOURNAMENT)(e,tp,eg,ep,ev,re,r,rp)
		and Duel.GetEnergyCount(tp)>=6 and Duel.GetEnergyCount(1-tp)>=6
end
--to deck
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	Duel.SelectTarget(tp,aux.LifeAreaFilter(Card.IsAbleToDeck),tp,0,LOCATION_LIFE,0,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	Duel.SelectTarget(tp,aux.EnergyAreaFilter(Card.IsAbleToDeck),tp,0,LOCATION_ENERGY,0,1,nil)
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
