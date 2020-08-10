--TB2-027 Begrudging Respect Piccolo
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_PICCOLO)
	aux.AddSpecialTrait(c,TRAIT_NAMEKIAN,TRAIT_GOD,TRAIT_WORLD_TOURNAMENT)
	aux.AddEra(c,ERA_MAJIN_BUU_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--barrier
	aux.EnableBarrier(c)
	--blocker
	aux.EnableBlocker(c,aux.ExistingCardCondition(aux.BattleAreaFilter(Card.IsCode,CARD_BEGRUDGING_RESPECT_VEGETA),LOCATION_BATTLE))
	--drop
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
--drop
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.CheckCharge(tp) and Duel.GetEnergyCount(tp)<Duel.GetEnergyCount(1-tp)
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.EnergyAreaFilter(Card.IsAbleToDrop),0,LOCATION_ENERGY,0,1,HINTMSG_DROP)
scard.op1=aux.TargetCardsOperation(Duel.SendtoDrop,REASON_EFFECT)
