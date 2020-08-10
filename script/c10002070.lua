--BT2-063 Father-Son Galick Gun
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,1)
	--extra card
	aux.EnableExtraAttribute(c)
	--return
	aux.AddActivateMainSkill(c,0,scard.op1,nil,scard.tg1,EFFECT_FLAG_CARD_TARGET)
end
--return
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(Card.IsAbleToHand),0,LOCATION_BATTLE,0,1,HINTMSG_RTOHAND)
scard.op1=aux.TargetSendtoHandOperation(nil)
