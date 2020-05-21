--TB2-013 Dark Duo Babidi
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_EVIL_WIZARD_BABIDI)
	aux.AddSpecialTrait(c,TRAIT_EVIL_WIZARD,TRAIT_WORLD_TOURNAMENT)
	aux.AddEra(c,ERA_THE_EVIL_WIZARD_BABIDI_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--barrier
	aux.EnableBarrier(c)
	--untap
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
scard.specified_cost={COLOR_RED,1}
scard.combo_cost=0
--untap
scard.con1=aux.SelfLeaderCondition(Card.IsColor,COLOR_RED)
function scard.untfilter(c)
	return c:IsColor(COLOR_RED) and c:IsPowerAbove(15000) and c:IsAbleToSwitchToActive()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(scard.untfilter),LOCATION_BATTLE,0,0,1,HINTMSG_TOACTIVE)
scard.op1=aux.TargetCardsOperation(Duel.SwitchtoActive,REASON_EFFECT)
