--BT3-104 Flying Nimbus
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--extra card
	aux.EnableExtraAttribute(c)
	--negate attack, drop, gain skill
	aux.AddCounterAttackSkill(c,0,scard.op1)
end
scard.specified_cost={COLOR_YELLOW,1}
--negate attack, drop, gain skill
function scard.dropfilter(c)
	return c:IsColor(COLOR_YELLOW) and c:IsAbleToDrop()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(aux.HandFilter(scard.dropfilter),tp,LOCATION_HAND,0,c)
	if g:GetCount()==0 or not Duel.SelectYesNo(tp,YESNOMSG_DROP) then return end
	Duel.BreakEffect()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DROP)
	local sg=g:Select(tp,1,1,nil)
	if Duel.SendtoDrop(sg,REASON_EFFECT)==0 then return end
	--cannot attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
	e1:SetTargetRange(0,LOCATION_BATTLE)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsBattle))
	e1:SetCondition(scard.con1)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(sid,1))
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CLIENT_HINT)
	e2:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e2,tp)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_ATTACK_ANNOUNCE)
	e3:SetOperation(scard.checkop)
	e3:SetLabelObject(e1)
	Duel.RegisterEffect(e3,tp)
end
function scard.con1(e)
	return e:GetHandler():GetFlagEffect(sid)>0
end
function scard.checkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:GetFlagEffect(sid)>0 then return end
	local fid=eg:GetFirst():GetFieldID()
	c:RegisterFlagEffect(sid,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,1)
	e:GetLabelObject():SetLabel(fid)
end
