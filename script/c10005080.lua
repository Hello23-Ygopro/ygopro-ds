--BT5-067 Super 17, Cell Absorbed
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,4)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_SUPER_17)
	aux.AddSpecialTrait(c,TRAIT_ANDROID,TRAIT_MACHINE_MUTANT)
	aux.AddEra(c,ERA_SPECIAL)
	--battle card
	aux.EnableBattleAttribute(c)
	--critical
	aux.EnableCritical(c)
	--dual attack
	aux.EnableDualAttack(c)
	--deflect
	aux.EnableDeflect(c)
	--sparking (drop)
	aux.EnableSparking(c)
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
--sparking (drop)
function scard.lfilter(c)
	return c:IsColor(COLOR_GREEN) and c:IsSpecialTrait(TRAIT_ANDROID)
end
scard.con1=aux.AND(aux.SparkingCondition(10),aux.SelfLeaderCondition(scard.lfilter))
scard.tg1=aux.TargetCardFunction(PLAYER_OPPO,aux.HandFilter(Card.IsAbleToDrop),0,LOCATION_HAND,2,2,HINTMSG_DROP)
scard.op1=aux.TargetCardsOperation(Duel.SendtoDrop,REASON_EFFECT)
