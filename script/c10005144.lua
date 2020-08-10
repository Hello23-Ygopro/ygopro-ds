--SD6-02 Fusion Reborn Vegeta
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_VEGETA)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_JANEMBA_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--untap
	aux.AddSingleAutoSkill(c,0,EVENT_DROP,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
--untap
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_HAND)
		and re and re:IsHasCategory(CATEGORY_UNION_FUSION)
		and aux.SelfLeaderCondition(Card.IsCharacter,CHARACTER_GOGETA)(e,tp,eg,ep,ev,re,r,rp)
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.EnergyAreaFilter(Card.IsAbleToSwitchToActive),LOCATION_ENERGY,0,0,1,HINTMSG_TOACTIVE)
scard.op1=aux.TargetCardsOperation(Duel.SwitchtoActive,REASON_EFFECT)
