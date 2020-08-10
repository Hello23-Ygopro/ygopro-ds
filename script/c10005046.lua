--BT5-040 Ghost Rampage SS Gotenks
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,2)
	aux.AddComboCost(c,0)
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
--burst (return)
function scard.thfilter(c)
	return c:IsPowerBelow(20000) and c:IsAbleToHand()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(scard.thfilter),0,LOCATION_BATTLE,0,100,HINTMSG_RTOHAND)
scard.op1=aux.TargetSendtoHandOperation(nil)
