--BT1-024 Assassination Plot
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--extra card
	aux.EnableExtraAttribute(c)
	--ko
	aux.AddActivateMainSkill(c,0,scard.op1,nil,scard.tg1,EFFECT_FLAG_CARD_TARGET)
end
scard.specified_cost={COLOR_RED,2}
--ko
scard.tg1=aux.TargetTotalPowerBelowTarget(PLAYER_SELF,aux.BattleAreaFilter(nil),0,LOCATION_BATTLE,30000,HINTMSG_KO)
scard.op1=aux.TargetCardsOperation(Duel.KO,REASON_EFFECT)
