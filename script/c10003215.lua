--TB1-056 Maiden Squadron Leader Ribrianne
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_RIBRIANNE)
	aux.AddSpecialTrait(c,TRAIT_ALIEN,TRAIT_MAIDEN_SQUADRON,TRAIT_UNIVERSE_2)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,TRAIT_CATEGORY_UNIVERSE)
	--battle card
	aux.EnableBattleAttribute(c)
	--evolve
	aux.EnableEvolve(c,aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_BRIANNE_DE_CHATEAU),aux.PaySkillCost(COLOR_GREEN,2,1))
	--barrier
	aux.EnableBarrier(c)
	--ko
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,aux.EvolvePlayCondition)
	--drop
	aux.AddSingleAutoSkill(c,1,EVENT_ATTACK_ANNOUNCE,scard.tg2,scard.op2,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
scard.specified_cost={COLOR_GREEN,2}
scard.combo_cost=1
--ko
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(nil),0,LOCATION_BATTLE,0,1,HINTMSG_KO)
scard.op1=aux.TargetCardsOperation(Duel.KO,REASON_EFFECT)
--drop
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(aux.BattleAreaFilter(Card.IsCharacter,CHARACTER_KAKUNSA),tp,LOCATION_BATTLE,0,1,nil)
		and Duel.IsExistingMatchingCard(aux.BattleAreaFilter(Card.IsCharacter,CHARACTER_ROZIE),tp,LOCATION_BATTLE,0,1,nil)
end
scard.tg2=aux.TargetCardFunction(PLAYER_SELF,aux.HandFilter(Card.IsAbleToDrop),0,LOCATION_HAND,0,2,HINTMSG_DROP)
scard.op2=aux.TargetCardsOperation(Duel.SendtoDrop,REASON_EFFECT)
