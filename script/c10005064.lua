--BT5-053_PR Tiny Warrior Son Goku (Alias)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_SON_GOKU_GT)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_SHENRON)
	aux.AddEra(c,ERA_BLACK_STAR_DRAGON_BALL_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_GT,CHAR_CATEGORY_SON_GOKU)
	--leader card
	aux.EnableLeaderAttribute(c)
	--choose one (draw or activate skill or gain skill)
	local e1=aux.AddActivateMainSkill(c,0,scard.op1,nil,scard.tg1)
	e1:SetCountLimit(1)
end
scard.front_side_code=sid-1
--choose one (draw or activate skill or gain skill)
function scard.actfilter(c,cost)
	if not (c:IsColor(COLOR_GREEN+COLOR_BLACK) and c:IsSpecialTrait(TRAIT_DESIRE) and c:IsEnergyBelow(cost)) then return false end
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
function scard.rmfilter(c)
	return c:IsHasEffect(EFFECT_DRAGON_BALL) and c:DSIsAbleToRemove()
end
function scard.dropfilter(c,e)
	return c:IsAbleToDrop() and c:IsCanBeEffectTarget(e)
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
		local g1=Duel.SelectMatchingCard(tp,aux.DropAreaFilter(scard.rmfilter),tp,LOCATION_DROP,0,7,7,nil)
		if Duel.RemoveFromGame(g1,REASON_EFFECT)==0 then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DROP)
		local g2=Duel.SelectMatchingCard(tp,aux.HandFilter(scard.dropfilter),tp,0,LOCATION_HAND,0,1,nil,e)
		if g2:GetCount()>0 then
			Duel.SetTargetCard(g2)
		end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DROP)
		local g3=Duel.SelectMatchingCard(tp,aux.BattleAreaFilter(scard.dropfilter),tp,0,LOCATION_BATTLE,0,1,nil,e)
		if g3:GetCount()>0 then
			Duel.SetTargetCard(g3)
			g2:Merge(g3)
		end
		Duel.SendtoDrop(g2,REASON_EFFECT)
		--gain power
		aux.AddTempSkillUpdatePower(c,c,5,15000)
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
