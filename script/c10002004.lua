--BT2-003 Babidi
--Not fully implemented: [Auto] skill does not activate
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_EVIL_WIZARD_BABIDI)
	aux.AddSpecialTrait(c,TRAIT_EVIL_WIZARD)
	aux.AddEra(c,ERA_THE_EVIL_WIZARD_BABIDI_SAGA)
	--leader card
	aux.EnableLeaderAttribute(c)
	--search (to battle)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetCategory(CATEGORY_AUTO)
	e1:SetType(EFFECT_TYPE_SINGLE+--[[EFFECT_TYPE_TRIGGER_F]]EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CUSTOM+EVENT_MOVE_LEADER)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	--e1:SetTarget(scard.tg1)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
	--awaken
	aux.EnableAwaken(c,aux.AwakenLifeCondition(6))
end
scard.back_side_code=sid+1
--search (to battle)
--scard.tg1=aux.TargetCardFunction(PLAYER_SELF,Card.IsCode,LOCATION_DECK,0,0,1,HINTMSG_TOBATTLE,nil,CARD_MAJIN_BUUS_SEALED_BALL)
function scard.tbfilter(c,e)
	return c:IsCode(CARD_MAJIN_BUUS_SEALED_BALL) and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	--local tc=Duel.GetFirstTarget()
	--if not tc or not tc:IsRelateToEffect(e) then return end
	--Duel.MoveToField(tc,tp,tp,LOCATION_FIELDCARD,POS_FACEUP,true)
	Duel.Hint(HINT_CARD,0,sid)
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOBATTLE)
	local g=Duel.SelectMatchingCard(tp,scard.tbfilter,tp,LOCATION_DECK,0,0,1,nil,e)
	if g:GetCount()==0 then return end
	Duel.SetTargetCard(g)
	Duel.MoveToField(g:GetFirst(),tp,tp,LOCATION_FIELDCARD,POS_FACEUP,true)
end
