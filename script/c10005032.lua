--BT5-027 Supreme Evil Janemba
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_JANEMBA)
	aux.AddSpecialTrait(c,TRAIT_EVIL_INCARNATE)
	aux.AddEra(c,ERA_JANEMBA_SAGA)
	--leader card
	aux.EnableLeaderAttribute(c)
	--sparking (draw, gain skill)
	aux.EnableSparking(c)
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.op1,nil,aux.SparkingCondition(5))
	--gain skill
	aux.AddActivateMainSkill(c,1,scard.op2,scard.cost1,nil,EFFECT_FLAG_CARD_TARGET)
end
scard.front_side_code=sid-1
--sparking (draw, gain skill)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	--gain power
	aux.AddTempSkillUpdatePower(c,c,3,5000)
	--critical
	aux.AddTempSkillCritical(c,c,4)
end
--gain skill
scard.cost1=aux.DropCost(aux.HandFilter(nil),LOCATION_HAND,0,1)
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	--drop
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(aux.Stringid(sid,2))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CHAINING)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetCondition(scard.con1)
	e1:SetOperation(scard.op3)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return rp==1-tp and re:IsHasCategory(CATEGORY_COUNTER_PLAY)
end
function scard.dropfilter(c,e)
	return c:IsAbleToDrop() and c:IsCanBeEffectTarget(e)
end
function scard.op3(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(aux.HandFilter(scard.dropfilter),tp,0,LOCATION_HAND,nil,e)
	if g:GetCount()==0 then return end
	Duel.Hint(HINT_CARD,0,sid)
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_DROP)
	local sg=g:Select(1-tp,3,3,nil)
	Duel.SetTargetCard(sg)
	Duel.SendtoDrop(sg,REASON_EFFECT)
end
