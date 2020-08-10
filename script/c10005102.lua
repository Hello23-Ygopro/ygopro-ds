--BT5-085 Krillin, Raring to Fight
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_KRILLIN)
	aux.AddSpecialTrait(c,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_RESURRECTION_F_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--tap
	aux.AddSingleAutoSkill(c,0,EVENT_CUSTOM+EVENT_COMBO,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
--tap
scard.con1=aux.SelfPreviousLocationCondition(LOCATION_BATTLE)
function scard.tapfilter(c)
	return (c:IsLeader() or c:IsBattle()) and c:IsPowerBelow(10000) and c:IsAbleToSwitchToRest()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.FaceupFilter(scard.tapfilter),0,LOCATION_INPLAY,0,1,HINTMSG_TOREST)
scard.op1=aux.TargetCardsOperation(Duel.SwitchtoRest,REASON_EFFECT)
