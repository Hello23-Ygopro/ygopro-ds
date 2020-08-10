--TB1-042 Universe 9 Striker Oregano
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_OREGANO)
	aux.AddSpecialTrait(c,TRAIT_ALIEN,TRAIT_UNIVERSE_9)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,TRAIT_CATEGORY_UNIVERSE)
	--battle card
	aux.EnableBattleAttribute(c)
	--to deck, draw
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,nil,scard.op1)
end
--to deck, draw
function scard.tdfilter(c)
	return c:IsSpecialTrait(TRAIT_UNIVERSE_9) and c:IsAbleToDeck()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local tc=Duel.SelectMatchingCard(tp,aux.HandFilter(scard.tdfilter),tp,LOCATION_HAND,0,0,1,nil):GetFirst()
	if not tc then return end
	if not tc:IsPublic() then Duel.ConfirmCards(1-tp,tc) end
	if Duel.SendtoDeck(tc,PLAYER_OWNER,SEQ_DECK_BOTTOM,REASON_EFFECT)>0 then
		Duel.Draw(tp,2,REASON_EFFECT)
	end
end
