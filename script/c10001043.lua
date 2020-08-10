--BT1-036 God Charge Vegeta
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,3)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_VEGETA)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_RESURRECTION_F_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--evolve
	aux.EnableEvolve(c,aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_VEGETA),aux.PaySkillCost(COLOR_BLUE,3,2))
	--dual attack
	aux.EnableDualAttack(c)
	--critical
	aux.EnableCritical(c)
	--return
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,aux.EvolvePlayCondition)
end
--return
function scard.retfilter(c)
	return c:IsAbleToHand() and c:IsHasEffect(EFFECT_BLOCKER)
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(scard.retfilter),0,LOCATION_BATTLE,0,1,HINTMSG_RTOHAND)
scard.op1=aux.TargetSendtoHandOperation(nil)
