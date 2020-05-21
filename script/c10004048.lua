--BT4-044 Ectoplasm
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--extra card
	aux.EnableExtraAttribute(c)
	--warp, gain skill
	aux.AddCounterPlaySkill(c,0,scard.op1,nil,scard.tg1,EFFECT_FLAG_CARD_TARGET)
end
--warp, gain skill
function scard.warpfilter(c)
	return c:IsCharacter(CHARACTER_HIRUDEGARN) and c:IsAbleToWarp()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(scard.warpfilter),LOCATION_BATTLE,0,0,1,HINTMSG_WARP)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) or Duel.SendtoWarp(tc,REASON_EFFECT)==0 then return end
	tc:RegisterFlagEffect(sid,RESET_EVENT+RESETS_STANDARD,0,0)
	--play
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(aux.Stringid(sid,1))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CUSTOM+EVENT_MAIN_PHASE_START)
	e1:SetCountLimit(1)
	e1:SetCondition(scard.con1)
	e1:SetOperation(scard.op2)
	e1:SetLabelObject(tc)
	e1:SetReset(RESET_PHASE+PHASE_MAIN1+RESET_SELF_TURN)
	Duel.RegisterEffect(e1,tp)
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabelObject():GetFlagEffect(sid)>0 and Duel.GetTurnPlayer()==tp then
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
	Duel.Play(tc,0,tp,tp,false,false,POS_FACEUP_ACTIVE)
end
