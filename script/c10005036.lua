--BT5-031 Surestrike Son Gohan
--Not fully implemented: Cards do not switch to Rest Mode when attacking
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_SON_GOHAN_ADOLESCENCE)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_JANEMBA_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOHAN)
	--battle card
	aux.EnableBattleAttribute(c)
	--search (drop), return, untap
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--search (drop), return, untap
function scard.dropfilter(c)
	return c:IsHasEffect(EFFECT_DRAGON_BALL) and c:IsAbleToDrop()
end
function scard.retfilter(c,e)
	return c:IsAbleToHand() and c:IsCanBeEffectTarget(e)
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.dropfilter,LOCATION_DECK,0,0,1,HINTMSG_DROP)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc1=Duel.GetFirstTarget()
	if not tc1 or not tc1:IsRelateToEffect(e) or Duel.SendtoDrop(tc1,REASON_EFFECT)==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local tc2=Duel.SelectMatchingCard(tp,aux.BattleAreaFilter(scard.retfilter),tp,0,LOCATION_BATTLE,0,1,nil,e):GetFirst()
	if not tc2 then return end
	Duel.SetTargetCard(tc2)
	Duel.SendtoHand(tc2,PLAYER_OWNER,REASON_EFFECT)
	local c=e:GetHandler()
	if tc2:GetOriginalEnergy()<=3 then
		--workaround to untap
		if c:GetFlagEffect(sid)>0 then
			c:ResetFlagEffect(sid)
		end
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_CUSTOM+EVENT_ATTACK_END)
		e1:SetCondition(scard.con1)
		e1:SetOperation(scard.op2)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(sid)==0
end
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsAbleToSwitchToActive() then return end
	Duel.Hint(HINT_CARD,0,sid)
	Duel.SwitchtoActive(c,REASON_EFFECT)
	c:RegisterFlagEffect(sid,RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END,0,1)
end
