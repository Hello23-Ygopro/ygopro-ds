--BT5-051 Call of Justice
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,1)
	--extra card
	aux.EnableExtraAttribute(c)
	--add special trait
	aux.AddPermanentAddSpecialTrait(c,TRAIT_DESIRE)
	--untap
	aux.AddActivateMainSkill(c,0,scard.op1,nil,scard.tg1,EFFECT_FLAG_CARD_TARGET,aux.SelfLeaderCondition(scard.lfilter))
end
--untap
function scard.lfilter(c)
	return c:IsColor(COLOR_BLUE) and c:IsSpecialTrait(TRAIT_SHENRON)
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.LeaderAreaFilter(Card.IsAbleToSwitchToActive),LOCATION_LEADER,0,1,1,HINTMSG_TOACTIVE)
scard.op1=aux.TargetCardsOperation(Duel.SwitchtoActive,REASON_EFFECT)
