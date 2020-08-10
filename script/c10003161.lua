--TB1-008 Foreseeing Hit
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_RED,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_HIT)
	aux.AddSpecialTrait(c,TRAIT_ALIEN,TRAIT_UNIVERSE_6)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,TRAIT_CATEGORY_UNIVERSE)
	--battle card
	aux.EnableBattleAttribute(c)
	--double strike
	aux.EnableDoubleStrike(c)
	--confirm, warp, gain skill
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,nil,scard.op1,EFFECT_FLAG_CARD_TARGET,aux.SelfPreviousLocationCondition(LOCATION_HAND))
end
--confirm, warp, gain skill
function scard.warpfilter(c,e)
	return c:IsBattle() and c:IsPowerBelow(35000) and c:IsAbleToWarp() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	if g1:GetCount()==0 then return end
	Duel.ConfirmCards(tp,g1)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_WARP)
	local g2=Duel.SelectMatchingCard(tp,aux.HandFilter(scard.warpfilter),tp,0,LOCATION_HAND,0,2,nil,e)
	if g2:GetCount()>0 then
		Duel.SetTargetCard(g2)
		Duel.SendtoWarp(g2,REASON_EFFECT)
		g2:KeepAlive()
		--to hand
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetDescription(aux.Stringid(sid,1))
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetCountLimit(1)
		e1:SetCondition(scard.con1)
		e1:SetOperation(scard.op2)
		e1:SetLabel(Duel.GetTurnCount())
		e1:SetLabelObject(g2)
		e1:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
		Duel.RegisterEffect(e1,tp)
	end
	Duel.ShuffleHand(1-tp)
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp and Duel.GetTurnCount()~=e:GetLabel()
end
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	if not g:IsExists(Card.IsAbleToHand,1,nil) then return end
	Duel.Hint(HINT_CARD,0,sid)
	Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,g)
end
