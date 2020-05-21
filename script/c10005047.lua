--BT5-040_SPR Ghost Rampage SS Gotenks (Alias)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_GOTENKS)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_JANEMBA_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--double strike
	aux.EnableDoubleStrike(c)
	--barrier
	aux.EnableBarrier(c)
	--burst (return)
	aux.EnableBurst(c)
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,nil,aux.BurstCost(5))
end
scard.specified_cost={COLOR_BLUE,2}
scard.combo_cost=0
--burst (return)
function scard.retfilter(c)
	return c:IsPowerBelow(20000) and c:IsAbleToHand()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(scard.retfilter),0,LOCATION_BATTLE,0,100,HINTMSG_RTOHAND)
scard.op1=aux.TargetSendtoHandOperation(nil)
