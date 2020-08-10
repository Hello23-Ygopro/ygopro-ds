--BT1-101 Zarbon, The Emperor's Attendant
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_ZARBON)
	aux.AddSpecialTrait(c,TRAIT_FRIEZAS_ARMY)
	aux.AddEra(c,ERA_FRIEZA_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--untap
	aux.AddSingleAutoSkill(c,0,EVENT_CUSTOM+EVENT_COMBO,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
--untap
scard.con1=aux.TurnPlayerCondition(PLAYER_OPPO)
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(Card.IsAbleToSwitchToActive),LOCATION_BATTLE,0,0,1,HINTMSG_TOACTIVE)
scard.op1=aux.TargetCardsOperation(Duel.SwitchtoActive,REASON_EFFECT)
