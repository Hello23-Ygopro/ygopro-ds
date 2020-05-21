--P-011 The Almighty Beam Fused Zamasu
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_ZAMASU)
	aux.AddSpecialTrait(c,TRAIT_GOD)
	aux.AddEra(c,ERA_FUTURE_TRUNKS_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--union-potara
	aux.EnableUnionPotara(c,scard.unipfilter1,scard.unipfilter2,aux.PaySkillCost(COLOR_BLUE,2,0))
	--to deck
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
scard.specified_cost={COLOR_BLUE,2}
scard.combo_cost=1
--union-potara
scard.unipfilter1=aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_GOKU_BLACK)
scard.unipfilter2=aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_ZAMASU)
--to deck
scard.con1=aux.SelfLeaderCondition(Card.IsCharacter,CHARACTER_ZAMASU)
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(Card.IsAbleToDeck),0,LOCATION_BATTLE,0,1,HINTMSG_TODECK)
scard.op1=aux.TargetCardsOperation(Duel.SendtoDeck,PLAYER_OWNER,SEQ_DECK_BOTTOM,REASON_EFFECT)
