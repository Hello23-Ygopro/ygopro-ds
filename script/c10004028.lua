--BT4-024 Awakened Perfection Hirudegarn
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_HIRUDEGARN)
	aux.AddSpecialTrait(c,TRAIT_PHANTOM_DEMON)
	aux.AddEra(c,ERA_HIRUDEGARN_SAGA)
	--leader card
	aux.EnableLeaderAttribute(c)
	--draw, to deck
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
scard.front_side_code=sid-1
--draw, to deck
function scard.tdfilter(c,e)
	return c:IsAbleToDeck() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	if Duel.GetEnergyCount(tp)<4 then return end
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(1-tp,aux.HandFilter(scard.tdfilter),1-tp,LOCATION_HAND,0,1,1,nil,e)
	if g:GetCount()==0 then return end
	Duel.BreakEffect()
	Duel.SetTargetCard(g)
	Duel.SendtoDeck(g,PLAYER_OWNER,SEQ_DECK_TOP,REASON_EFFECT)
end
