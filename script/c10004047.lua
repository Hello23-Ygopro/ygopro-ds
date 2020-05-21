--BT4-043 Phantom Flame Cannon
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--extra card
	aux.EnableExtraAttribute(c)
	--gain skill, to deck
	aux.AddActivateBattleSkill(c,0,scard.op1,nil,nil,EFFECT_FLAG_CARD_TARGET,aux.SelfLeaderCondition(Card.IsCharacter,CHARACTER_HIRUDEGARN))
end
scard.specified_cost={COLOR_BLUE,1}
--gain skill, to deck
function scard.tdfilter(c,e)
	return c:IsAbleToDeck() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	--gain power
	aux.AddTempSkillUpdatePower(e:GetHandler(),Duel.GetLeaderCard(tp),1,10000,RESET_PHASE+PHASE_DAMAGE)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,aux.HandFilter(scard.tdfilter),tp,0,LOCATION_HAND,0,1,nil,e)
	if g:GetCount()==0 then return end
	Duel.BreakEffect()
	Duel.SetTargetCard(g)
	Duel.SendtoDeck(g,PLAYER_OWNER,SEQ_DECK_TOP,REASON_EFFECT)
end
