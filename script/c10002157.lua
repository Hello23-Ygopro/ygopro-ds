--EX02-03 Supreme Kai of Time, Continuity Keeper
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_SUPREME_KAI_OF_TIME)
	aux.AddSpecialTrait(c,TRAIT_GOD)
	aux.AddEra(c,ERA_DARK_DEMON_REALM_SAGA)
	aux.AddCategory(c,NAME_CATEGORY_SUPREME_KAI)
	--battle card
	aux.EnableBattleAttribute(c)
	--search (warp, gain skill)
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
scard.combo_cost=0
--search (warp, gain skill)
function scard.warpfilter(c)
	return c:IsBattle() and c:IsColor(COLOR_BLACK) and c:IsEnergyBelow(5) and c:IsAbleToWarp()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.warpfilter,LOCATION_DECK,0,0,1,HINTMSG_WARP)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SendtoWarp(tc,REASON_EFFECT)
		tc:RegisterFlagEffect(sid,RESET_EVENT+RESETS_STANDARD,0,0)
	end
	Duel.BreakEffect()
	local c=e:GetHandler()
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,1))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_DRAW)
	e1:SetRange(LOCATION_BATTLE)
	e1:SetCountLimit(1)
	e1:SetCondition(scard.con1)
	e1:SetOperation(scard.op2)
	e1:SetLabelObject(tc)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DRAW+RESET_SELF_TURN)
	c:RegisterEffect(e1)
end
--to hand
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc:GetFlagEffect(sid)==0 then
		e:Reset()
		return false
	else
		return Duel.GetTurnPlayer()==tp
	end
end
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if not tc:IsAbleToHand() then return end
	Duel.Hint(HINT_CARD,0,sid)
	Duel.SendtoHand(tc,PLAYER_OWNER,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,tc)
end
