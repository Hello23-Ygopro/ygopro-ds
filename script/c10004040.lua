--BT4-036 Colossal Malice Hirudegarn
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,6)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_HIRUDEGARN)
	aux.AddSpecialTrait(c,TRAIT_PHANTOM_DEMON)
	aux.AddEra(c,ERA_HIRUDEGARN_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--ex-evolve
	aux.EnableEXEvolve(c,scard.evofilter,aux.PaySkillCost(COLOR_BLUE,2,2))
	--barrier
	aux.EnableBarrier(c)
	--to deck
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
	--warp, negate attack, gain skill
	aux.AddAutoSkill(c,1,EVENT_ATTACK_ANNOUNCE,nil,scard.op2,nil,scard.con1)
end
--ex-evolve
function scard.evofilter(c)
	return c:IsCharacter(CHARACTER_HIRUDEGARN) and c:IsEnergyAbove(7)
end
--to deck
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	Duel.SelectTarget(tp,aux.BattleAreaFilter(Card.IsAbleToDeck),tp,0,LOCATION_BATTLE,0,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	Duel.SelectTarget(tp,aux.HandFilter(Card.IsAbleToDeck),tp,0,LOCATION_HAND,0,1,nil)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if not g then return end
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	if Duel.SendtoDeck(sg,PLAYER_OWNER,SEQ_DECK_TOP,REASON_EFFECT)==0 then return end
	local dg1=Duel.GetOperatedGroup():Filter(Card.IsControler,nil,tp)
	local dg2=Duel.GetOperatedGroup():Filter(Card.IsControler,nil,1-tp)
	if dg1:GetCount()>1 then Duel.SortDecktop(tp,tp,dg1:GetCount()) end
	if dg2:GetCount()>1 then Duel.SortDecktop(tp,1-tp,dg2:GetCount()) end
end
--warp, negate attack, gain skill
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	return tc and tc:IsControler(1-tp)
		and aux.SelfLeaderCondition(Card.IsSpecialTrait,TRAIT_PHANTOM_DEMON)(e,tp,eg,ep,ev,re,r,rp)
end
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(aux.HandFilter(Card.IsAbleToWarp),tp,LOCATION_HAND,0,nil)
	if g:GetCount()==0 or not Duel.SelectYesNo(tp,YESNOMSG_WARP) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_WARP)
	local sg=g:Select(tp,1,1,nil)
	sg:AddCard(c)
	if Duel.SendtoWarp(sg,REASON_EFFECT)==0 then return end
	Duel.NegateAttack()
	--play
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,2))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CUSTOM+EVENT_MAIN_PHASE_START)
	e1:SetRange(LOCATION_WARP)
	e1:SetCountLimit(1)
	e1:SetCondition(aux.TurnPlayerCondition(PLAYER_SELF))
	e1:SetOperation(scard.op3)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_MAIN1+RESET_SELF_TURN)
	c:RegisterEffect(e1)
end
--play
function scard.op3(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsCanBePlayed(e,0,tp,false,false) then return end
	Duel.Hint(HINT_CARD,0,sid)
	Duel.Play(c,0,tp,tp,false,false,POS_FACEUP_ACTIVE)
end
