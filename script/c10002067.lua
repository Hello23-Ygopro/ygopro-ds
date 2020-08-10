--BT2-060 Zen-Oh, The Plain God
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,3)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_ZEN_OH)
	aux.AddSpecialTrait(c,TRAIT_GOD)
	aux.AddEra(c,ERA_FUTURE_TRUNKS_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--negate skill, to deck, draw
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,nil,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--negate skill, to deck, draw
function scard.tdfilter(c,e)
	return c:IsAbleToDeck() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g1=Duel.GetMatchingGroup(aux.BattleAreaFilter(nil),tp,LOCATION_BATTLE,LOCATION_BATTLE,c)
	for tc in aux.Next(g1) do
		--negate skill
		aux.AddTempSkillNegateSkill(c,tc,1,0)
	end
	local g2=Duel.GetMatchingGroup(aux.HandFilter(scard.tdfilter),tp,LOCATION_HAND,LOCATION_HAND,nil,e)
	local g3=Duel.GetMatchingGroup(aux.BattleAreaFilter(scard.tdfilter),tp,LOCATION_BATTLE,LOCATION_BATTLE,c,e)
	g2:Merge(g3)
	Duel.BreakEffect()
	Duel.SetTargetCard(g2)
	Duel.SendtoDeck(g2,PLAYER_OWNER,SEQ_DECK_SHUFFLE,REASON_EFFECT)
	local sg=g2:Filter(Card.IsLocation,nil,LOCATION_DECK)
	if sg:IsExists(Card.IsControler,1,nil,tp) then Duel.ShuffleDeck(tp) end
	if sg:IsExists(Card.IsControler,1,nil,1-tp) then Duel.ShuffleDeck(1-tp) end
	Duel.BreakEffect()
	Duel.Draw(tp,5,REASON_EFFECT)
	Duel.Draw(1-tp,5,REASON_EFFECT)
end
