--BT4-031 Sneak Attack Vegeta
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_VEGETA)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_HIRUDEGARN_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--barrier
	aux.EnableBarrier(c)
	--to deck
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,aux.SelfAttackTargetCondition(Card.IsLeader))
end
--to deck
scard.tg1=aux.TargetCardFunction(PLAYER_OPPO,aux.HandFilter(Card.IsAbleToDeck),0,LOCATION_HAND,1,1,HINTMSG_TODECK)
scard.op1=aux.TargetCardsOperation(Duel.SendtoDeck,PLAYER_OWNER,SEQ_DECK_TOP,REASON_EFFECT)
