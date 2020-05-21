--BT2-036 Goku Black
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_GOKU_BLACK)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_GOD)
	aux.AddEra(c,ERA_FUTURE_TRUNKS_SAGA)
	--leader card
	aux.EnableLeaderAttribute(c)
	--charge, gain skill
	local e1=aux.AddActivateMainSkill(c,0,scard.op1,nil,scard.tg1,EFFECT_FLAG_CARD_TARGET,scard.con1)
	e1:SetCountLimit(1)
	--awaken
	aux.EnableAwaken(c)
end
scard.back_side_code=sid+1
--charge, gain skill
scard.con1=aux.ExistingCardCondition(aux.EnergyAreaFilter(Card.IsColor,COLOR_BLUE),LOCATION_ENERGY,0,2)
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.LifeAreaFilter(Card.IsAbleToEnergy),LOCATION_LIFE,0,1,1,HINTMSG_TOENERGY)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SendtoEnergy(tc,POS_FACEUP_ACTIVE,REASON_EFFECT)
	end
	--drop
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(aux.Stringid(sid,1))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
	e1:SetOperation(scard.op2)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function scard.dropfilter(c,e)
	return c:IsAbleToDrop() and c:IsCanBeEffectTarget(e)
end
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(aux.EnergyAreaFilter(scard.dropfilter),tp,LOCATION_ENERGY,0,nil,e)
	if g:GetCount()==0 then return end
	Duel.Hint(HINT_CARD,0,sid)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DROP)
	local sg=g:Select(tp,1,1,nil)
	Duel.SetTargetCard(sg)
	Duel.SendtoDrop(sg,REASON_EFFECT)
end
