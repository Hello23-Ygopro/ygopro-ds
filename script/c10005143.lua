--SD6-01 Knockout Strike Gogeta
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_GOGETA)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_JANEMBA_SAGA)
	--leader card
	aux.EnableLeaderAttribute(c)
	--sparking (draw, gain skill)
	aux.EnableSparking(c)
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.op1,nil,aux.SparkingCondition(5))
	--gain skill
	local e1=aux.AddActivateMainSkill(c,1,scard.op2,scard.cost1,nil,EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
end
scard.front_side_code=sid-1
--sparking (draw, gain skill)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	local ct=Duel.GetEnergyCount(tp)
	if ct>=3 then
		--gain power
		aux.AddTempSkillUpdatePower(c,c,2,5000)
	end
	if ct>=5 then
		--double strike
		aux.AddTempSkillCustom(c,c,3,EFFECT_DOUBLE_STRIKE)
	end
end
--gain skill
scard.cost1=aux.DropCost(aux.HandFilter(nil),LOCATION_HAND,0,1,1,true)
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	--cannot activate
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(aux.Stringid(sid,4))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CLIENT_HINT)
	e1:SetTargetRange(0,1)
	e1:SetValue(scard.val1)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function scard.val1(e,re,tp)
	return not re:IsHasCategory(CATEGORY_COUNTER)
		--exclude rule-related effects
		and not re:SetProperty(EFFECT_FLAG_CANNOT_DISABLE) and not re:SetProperty(EFFECT_FLAG_UNCOPYABLE)
end
