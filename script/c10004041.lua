--BT4-037 Impenetrable Defense Hirudegarn
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_HIRUDEGARN)
	aux.AddSpecialTrait(c,TRAIT_PHANTOM_DEMON)
	aux.AddEra(c,ERA_HIRUDEGARN_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--barrier
	aux.EnableBarrier(c)
	--warp, gain skill
	aux.AddAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.op1,nil,scard.con1)
end
scard.specified_cost={COLOR_BLUE,4}
scard.combo_cost=1
--warp, gain skill
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	return tc and tc:IsControler(1-tp)
		and aux.SelfLeaderCondition(Card.IsSpecialTrait,TRAIT_PHANTOM_DEMON)(e,tp,eg,ep,ev,re,r,rp)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
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
	e1:SetDescription(aux.Stringid(sid,1))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CUSTOM+EVENT_MAIN_PHASE_START)
	e1:SetRange(LOCATION_WARP)
	e1:SetCountLimit(1)
	e1:SetCondition(aux.TurnPlayerCondition(PLAYER_SELF))
	e1:SetOperation(scard.op2)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_MAIN1+RESET_SELF_TURN)
	c:RegisterEffect(e1)
end
--play
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsCanBePlayed(e,0,tp,false,false) then return end
	Duel.Hint(HINT_CARD,0,sid)
	Duel.Play(c,0,tp,tp,false,false,POS_FACEUP_ACTIVE)
end
