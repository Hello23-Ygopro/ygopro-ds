--BT1-099 Ginyu Force Guldo
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_GULDO)
	aux.AddSpecialTrait(c,TRAIT_GINYU_FORCE,TRAIT_FRIEZAS_ARMY)
	aux.AddEra(c,ERA_FRIEZA_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--tap
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
--tap
scard.con1=aux.SelfLeaderCondition(Card.IsSpecialTrait,TRAIT_GINYU_FORCE)
function scard.tapfilter(c)
	return c:IsEnergyBelow(2) and c:IsAbleToSwitchToRest()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(scard.tapfilter),0,LOCATION_BATTLE,0,1,HINTMSG_TOREST)
scard.op1=aux.TargetCardsOperation(Duel.SwitchtoRest,REASON_EFFECT)
