--BT2-097 Enraged Gohan Awakening
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,2)
	--extra card
	aux.EnableExtraAttribute(c)
	--ko
	aux.AddCounterAttackSkill(c,0,scard.op1,scard.cost1,scard.tg1,EFFECT_FLAG_CARD_TARGET)
end
--ko
scard.cost1=aux.DropCost(aux.HandFilter(nil),LOCATION_HAND,0,1)
function scard.kofilter(c)
	return Duel.GetAttacker()==c
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(scard.kofilter),0,LOCATION_BATTLE,1,1,HINTMSG_KO)
scard.op1=aux.TargetCardsOperation(Duel.KO,REASON_EFFECT)
