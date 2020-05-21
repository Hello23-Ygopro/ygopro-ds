--TB1-024 Time Kicker
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--extra card
	aux.EnableExtraAttribute(c)
	--negate attack, warp, gain skill
	aux.AddCounterAttackSkill(c,0,scard.op1,nil,nil,EFFECT_FLAG_CARD_TARGET)
end
scard.specified_cost={COLOR_RED,1}
--negate attack, warp, gain skill
function scard.warpfilter(c,e)
	return c:IsAbleToWarp() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
	local tc1=Duel.GetAttacker()
	if not aux.SelfLeaderCondition(Card.IsSpecialTrait,TRAIT_UNIVERSE_6)(e,tp,eg,ep,ev,re,r,rp)
		or not tc1:IsBattle() then return end
	local g=Group.FromCards(tc1)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_WARP)
	local tc2=g:FilterSelect(tp,scard.warpfilter,0,1,nil,e):GetFirst()
	if not tc2 then return end
	Duel.SetTargetCard(tc2)
	Duel.SendtoWarp(tc2,REASON_EFFECT)
	tc2:RegisterFlagEffect(sid,RESET_EVENT+RESETS_STANDARD,0,0)
	--play
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(aux.Stringid(sid,1))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetCountLimit(1)
	e1:SetCondition(scard.con1)
	e1:SetOperation(scard.op2)
	e1:SetLabelObject(tc2)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabelObject():GetFlagEffect(sid)>0 then
		return true
	else
		e:Reset()
		return false
	end
end
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if not tc:IsCanBePlayed(e,0,tp,false,false) then return end
	Duel.Hint(HINT_CARD,0,sid)
	Duel.Play(tc,0,1-tp,tc:GetOwner(),false,false,POS_FACEUP_ACTIVE)
end
