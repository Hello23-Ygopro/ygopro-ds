--BT2-034 Absolute God Fused Zamasu
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_ZAMASU)
	aux.AddSpecialTrait(c,TRAIT_GOD)
	aux.AddEra(c,ERA_FUTURE_TRUNKS_SAGA)
	--leader card
	aux.EnableLeaderAttribute(c)
	--change damage
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CHANGE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(LOCATION_LEADER)
	e1:SetTargetRange(1,0)
	e1:SetValue(scard.val1)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_ADJUST)
	e2:SetRange(LOCATION_LEADER)
	e2:SetCondition(scard.con1)
	e2:SetOperation(scard.op1)
	e2:SetLabelObject(e1)
	c:RegisterEffect(e2)
	--draw
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,aux.DuelOperation(Duel.Draw,PLAYER_SELF,1,REASON_EFFECT))
end
scard.front_side_code=sid-1
--change damage
function scard.val1(e,re,val,r,rp,rc)
	e:SetLabel(val)
	e:GetHandler():ResetFlagEffect(sid)
	return 0
end
function scard.con1(e)
	local val=e:GetLabelObject():GetLabel()
	e:SetLabel(val)
	return val~=0 and e:GetHandler():GetFlagEffect(sid)==0
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsPlayerCanSendDecktoDrop(tp,1) then return end
	Duel.Hint(HINT_CARD,0,sid)
	Duel.SendDecktoDrop(tp,e:GetLabel()*5,REASON_EFFECT)
	e:GetHandler():RegisterFlagEffect(sid,RESET_EVENT+RESETS_STANDARD,0,1)
end
