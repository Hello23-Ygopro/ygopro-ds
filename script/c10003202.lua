--TB1-046 Spectrum Attack Obuni
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_OBUNI)
	aux.AddSpecialTrait(c,TRAIT_ALIEN,TRAIT_UNIVERSE_10)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,TRAIT_CATEGORY_UNIVERSE)
	--battle card
	aux.EnableBattleAttribute(c)
	--draw, to deck
	aux.AddSingleAutoSkill(c,0,EVENT_CUSTOM+EVENT_COMBO,nil,scard.op1)
end
scard.specified_cost={COLOR_BLUE,2}
scard.combo_cost=1
--draw, to deck
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.Draw(tp,1,REASON_EFFECT)>0 then Duel.ShuffleHand(tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,aux.HandFilter(Card.IsAbleToDeck),tp,LOCATION_HAND,0,1,1,nil)
	Duel.SendtoDeck(g,PLAYER_OWNER,SEQ_DECK_BOTTOM,REASON_EFFECT)
end
