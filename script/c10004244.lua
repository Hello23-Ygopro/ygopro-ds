--TB2-044 Best Buddy Chiaotzu
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_CHIAOTZU)
	aux.AddSpecialTrait(c,TRAIT_EARTHLING,TRAIT_WORLD_TOURNAMENT)
	aux.AddEra(c,ERA_WORLD_MA_TOURNAMENT_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--untap
	aux.AddSingleAutoSkill(c,0,EVENT_CUSTOM+EVENT_COMBO,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,aux.TurnPlayerCondition(PLAYER_SELF))
end
scard.specified_cost={COLOR_GREEN,1}
scard.combo_cost=1
--untap
function scard.untfilter(c)
	return c:IsCode(CARD_TIEN_SHINHAN_TRADING_MOVES) and c:IsAbleToSwitchToActive()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(scard.untfilter),LOCATION_BATTLE,0,0,1,HINTMSG_TOACTIVE)
scard.op1=aux.TargetCardsOperation(Duel.SwitchtoActive,REASON_EFFECT)
