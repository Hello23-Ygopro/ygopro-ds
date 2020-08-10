--BT2-118 Tobi, The Obedient Soldier
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_TOBI)
	aux.AddSpecialTrait(c,TRAIT_CHILLEDS_ARMY)
	aux.AddEra(c,ERA_CHILLED_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--double strike
	aux.EnableDoubleStrike(c)
	--tap
	local e1=aux.AddActivateMainSkill(c,0,scard.op1,scard.cost1,scard.tg1,EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
end
--tap
scard.cost1=aux.SwitchtoRestCost(aux.BattleAreaFilter(Card.IsCode,CARD_BT2102_CHILLEDS_ARMY_TOKEN),LOCATION_BATTLE,0,1)
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(Card.IsAbleToSwitchToRest),0,LOCATION_BATTLE,1,1,HINTMSG_TOREST)
scard.op1=aux.TargetCardsOperation(Duel.SwitchtoRest,REASON_EFFECT)
