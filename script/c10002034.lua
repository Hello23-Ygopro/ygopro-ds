--BT2-031 Majin Buu's Sealed Ball
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_RED,1)
	--extra card
	aux.EnableExtraAttribute(c)
	--field
	aux.EnableField(c)
	--search (drop, play)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_ADJUST)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_FIELD)
	e1:SetOperation(scard.regop1)
	c:RegisterEffect(e1)
	local e2=aux.AddSingleAutoSkill(c,0,EVENT_CUSTOM+sid,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_FIELD)
	e2:SetCountLimit(1)
end
--search (drop, play)
function scard.regop1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:GetAbsorbedCount()>=5 then
		Duel.RaiseSingleEvent(c,EVENT_CUSTOM+sid,e,0,0,0,0)
	end
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsRelateToEffect(e) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function scard.playfilter(c,e,tp)
	return c:IsCode(CARD_MAJIN_BUU_REVIVED) and c:IsCanBePlayed(e,0,tp,false,false) and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendtoDrop(e:GetHandler(),REASON_EFFECT)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_PLAY)
	local g=Duel.SelectMatchingCard(tp,scard.playfilter,tp,LOCATION_DECK,0,0,1,nil,e,tp)
	if g:GetCount()==0 then return end
	Duel.BreakEffect()
	Duel.SetTargetCard(g)
	Duel.Play(g,0,tp,tp,false,false,POS_FACEUP_ACTIVE)
end
