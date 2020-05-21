--SD7-01 Miraculous Arrival Shenron
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_SHENRON)
	aux.AddSpecialTrait(c,TRAIT_SHENRON)
	aux.AddEra(c,ERA_SPECIAL)
	--leader card
	aux.EnableLeaderAttribute(c)
	--cannot attack
	aux.AddSinglePermanentSkill(c,EFFECT_CANNOT_ATTACK)
	--choose one (draw or activate skill or gain skill)
	local e1=aux.AddActivateMainSkill(c,0,scard.op1,nil,scard.tg1)
	e1:SetCountLimit(1)
end
scard.front_side_code=sid-1
--choose one (draw or activate skill or gain skill)
function scard.actfilter(c,cost)
	if not (c:IsSpecialTrait(TRAIT_DESIRE) and c:IsEnergyBelow(cost)) then return false end
	local m=_G["c"..c:GetCode()]
	return m and m.activate_main_skill
end
function scard.rmfilter(c)
	return c:IsHasEffect(EFFECT_DRAGON_BALL) and c:DSIsAbleToRemove()
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local cost=Duel.GetEnergyCount(tp)
	local f=aux.HandFilter(scard.actfilter)
	local b1=Duel.IsPlayerCanDraw(tp,1)
	local b2=Duel.IsExistingTarget(f,tp,LOCATION_HAND,0,1,nil,cost)
	local b3=Duel.IsExistingMatchingCard(aux.DropAreaFilter(scard.rmfilter),tp,LOCATION_DROP,0,7,nil)
	if chkc then
		if b2 then
			return chkc:IsLocation(LOCATION_HAND) and chkc:IsControler(tp) and f(chkc,cost)
		else
			return false
		end
	end
	if chk==0 then return b1 or b2 or b3 end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	local option_list={}
	local t={}
	if b1 then
		table.insert(option_list,aux.Stringid(sid,1))
		table.insert(t,1)
	end
	if b2 then
		table.insert(option_list,aux.Stringid(sid,2))
		table.insert(t,2)
	end
	if b3 then
		table.insert(option_list,aux.Stringid(sid,3))
		table.insert(t,3)
	end
	local opt=t[Duel.SelectOption(tp,table.unpack(option_list))+1]
	e:SetLabel(opt)
	if opt==2 then
		e:SetProperty(EFFECT_FLAG_CARD_TARGET)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ACTIVATESKILL)
		Duel.SelectTarget(tp,f,tp,LOCATION_HAND,0,1,1,nil,cost)
	elseif opt==3 then
		e:SetProperty(EFFECT_FLAG_CARD_TARGET)
	end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local opt=e:GetLabel()
	if opt==1 then
		Duel.Draw(tp,1,REASON_EFFECT)
	elseif opt==2 then
		local tc=Duel.GetFirstTarget()
		if tc and tc:IsRelateToEffect(e) then
			Duel.ActivateMainSkill(tc,tp)
		end
	elseif opt==3 then
		local c=e:GetHandler()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local g=Duel.SelectMatchingCard(tp,aux.DropAreaFilter(scard.rmfilter),tp,LOCATION_DROP,0,7,7,nil)
		if Duel.RemoveFromGame(g,REASON_EFFECT)==0 then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
		local tc=Duel.SelectMatchingCard(tp,aux.BattleAreaFilter(Card.IsCanBeEffectTarget),tp,LOCATION_BATTLE,0,1,1,nil,e):GetFirst()
		if tc then
			Duel.SetTargetCard(tc)
			--gain power
			aux.AddTempSkillUpdatePower(c,tc,5,10000)
			--triple attack
			aux.AddTempSkillTripleAttack(c,tc,6)
		end
		--flip over
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringid(sid,4))
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetRange(LOCATION_LEADER)
		e1:SetCountLimit(1)
		e1:SetOperation(scard.op2)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.FlipOver(e:GetHandler(),REASON_EFFECT)
end
