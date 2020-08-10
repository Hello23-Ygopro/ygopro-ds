--BT2-054 Unstoppable Despair Goku Black Rosé
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,3)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_GOKU_BLACK)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_GOD)
	aux.AddEra(c,ERA_FUTURE_TRUNKS_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--evolve
	aux.EnableEvolve(c,aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_GOKU_BLACK),aux.PaySkillCost(COLOR_BLUE,3,4))
	--triple strike
	aux.EnableTripleStrike(c)
	--drop
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
--drop
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return aux.EvolvePlayCondition(e,tp,eg,ep,ev,re,r,rp)
		and aux.SelfLeaderCondition(Card.IsCharacter,CHARACTER_GOKU_BLACK)(e,tp,eg,ep,ev,re,r,rp)
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.EnergyAreaFilter(Card.IsAbleToDrop),0,LOCATION_ENERGY,0,3,HINTMSG_DROP)
scard.op1=aux.TargetCardsOperation(Duel.SendtoDrop,REASON_EFFECT)
