--BT1-077 Paragus, Controller of Monsters
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_PARAGUS)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_BROLY_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--search (drop, activate)
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,nil,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--search (drop, activate)
function scard.actfilter(c,tp)
	return c:IsCode(CARD_BROLYS_RING) and c:GetActivateEffect():IsActivatable(tp,true,true)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DROP)
	local g=Duel.SelectMatchingCard(tp,aux.HandFilter(Card.IsAbleToDrop),tp,LOCATION_HAND,0,0,1,nil)
	if g:GetCount()==0 or Duel.SendtoDrop(g,REASON_EFFECT)==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ACTIVATECARD)
	local tc=Duel.SelectMatchingCard(tp,scard.actfilter,tp,LOCATION_DECK,0,0,1,nil,tp):GetFirst()
	if not tc then return end
	Duel.SetTargetCard(tc)
	local fc=Duel.GetFieldCard(tp,LOCATION_FIELDCARD,SEQ_FZONE)
	if fc then
		Duel.SendtoDrop(fc,REASON_RULE)
		Duel.BreakEffect()
	end
	Duel.MoveToField(tc,tp,tp,LOCATION_FIELDCARD,POS_FACEUP,true)
	local te=tc:GetActivateEffect()
	local tep=tc:GetControler()
	local cost=te:GetCost()
	if cost then cost(te,tep,eg,ep,ev,re,r,rp,1) end
end
