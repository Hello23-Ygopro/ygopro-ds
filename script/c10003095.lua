--BT3-086 Striker Bardock
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_BARDOCK)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_BARDOCK_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--dual attack
	aux.EnableDualAttack(c)
	--to hand
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
--to hand
scard.con1=aux.SelfLeaderCondition(Card.IsSpecialTrait,TRAIT_SAIYAN)
scard.tg1=aux.TargetDecktopTarget(Card.IsAbleToHand,3,0,1,HINTMSG_ATOHAND)
scard.op1=aux.TargetDecktopSendtoHandOperation(3,LOCATION_DROP,true)
