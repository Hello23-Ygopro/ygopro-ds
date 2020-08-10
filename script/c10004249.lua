--TB2-048 Mercenary Tao, Trading Moves
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_MERCENARY_TAO)
	aux.AddSpecialTrait(c,TRAIT_EARTHLING,TRAIT_WORLD_TOURNAMENT)
	aux.AddEra(c,ERA_WORLD_MA_TOURNAMENT_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--double strike
	aux.EnableDoubleStrike(c)
	--drop
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
--drop
function scard.lfilter(c)
	return c:IsColor(COLOR_GREEN) and c:IsSpecialTrait(TRAIT_WORLD_TOURNAMENT)
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return aux.SelfLeaderCondition(scard.lfilter)(e,tp,eg,ep,ev,re,r,rp)
		and Duel.IsExistingMatchingCard(aux.BattleAreaFilter(Card.IsCode,CARD_TIEN_SHINHAN_TRADING_MOVES),tp,LOCATION_BATTLE,0,1,nil)
end
scard.tg1=aux.TargetCardFunction(PLAYER_OPPO,aux.HandFilter(Card.IsAbleToDrop),0,LOCATION_HAND,3,3,HINTMSG_DROP)
scard.op1=aux.TargetCardsOperation(Duel.SendtoDrop,REASON_EFFECT)
