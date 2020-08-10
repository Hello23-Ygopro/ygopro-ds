--BT4-062 Adonic Warrior Angila
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_ANGILA)
	aux.AddSpecialTrait(c,TRAIT_SLUGS_ARMY)
	aux.AddEra(c,ERA_LORD_SLUG_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--critical
	aux.EnableCritical(c)
	--bond (drop)
	aux.EnableBond(c)
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
--bond (drop)
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return aux.BondCondition(2,Card.IsSpecialTrait,TRAIT_SLUGS_ARMY)(e,tp,eg,ep,ev,re,r,rp)
		and aux.SelfLeaderCondition(Card.IsSpecialTrait,TRAIT_SLUGS_ARMY)(e,tp,eg,ep,ev,re,r,rp)
end
scard.tg1=aux.TargetCardFunction(PLAYER_OPPO,aux.HandFilter(Card.IsAbleToDrop),0,LOCATION_HAND,1,1,HINTMSG_DROP)
scard.op1=aux.TargetCardsOperation(Duel.SendtoDrop,REASON_EFFECT)
