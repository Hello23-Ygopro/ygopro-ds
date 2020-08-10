--P-010 Intrepid Determination Bardock
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_BARDOCK)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_CHILLED_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--ko
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--ko
scard.tg1=aux.TargetTotalCostBelowTarget(PLAYER_SELF,aux.BattleAreaFilter(nil),0,LOCATION_BATTLE,3,HINTMSG_KO)
scard.op1=aux.TargetCardsOperation(Duel.KO,REASON_EFFECT)
