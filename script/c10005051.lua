--BT5-044 East Kai, Keeping Watch
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_EAST_KAI)
	aux.AddSpecialTrait(c,TRAIT_GOD)
	aux.AddEra(c,ERA_JANEMBA_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--draw
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,nil,aux.DuelOperation(Duel.Draw,PLAYER_SELF,1,REASON_EFFECT))
	--to deck
	aux.AddAutoSkill(c,1,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
scard.specified_cost={COLOR_BLUE,1}
scard.combo_cost=0
--to deck
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
		and eg:IsExists(aux.BattleAreaFilter(aux.FilterEqualFunction(Card.GetPlayPlayer,1-tp)),1,nil)
end
scard.tg1=aux.TargetCardFunction(PLAYER_OPPO,aux.HandFilter(Card.IsAbleToDeck),0,LOCATION_HAND,1,1,HINTMSG_TODECK)
scard.op1=aux.TargetCardsOperation(Duel.SendtoDeck,PLAYER_OWNER,SEQ_DECK_BOTTOM,REASON_EFFECT)
