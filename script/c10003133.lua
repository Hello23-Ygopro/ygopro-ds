--BT3-120 Haru Haru, Attacker Majin
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_HARU_HARU)
	aux.AddSpecialTrait(c,TRAIT_DEMON_REALM_RACE)
	aux.AddEra(c,ERA_DARK_DEMON_REALM_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--critical
	aux.EnableCritical(c)
	--drop
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,nil,aux.DuelOperation(Duel.SendDecktoDropUpTo,PLAYER_SELF,2,REASON_EFFECT))
	--untap
	aux.AddSingleAutoSkill(c,1,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
--untap
scard.con1=aux.OppoLeaderCondition(Card.IsColor,COLOR_GREEN+COLOR_YELLOW)
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.EnergyAreaFilter(Card.IsAbleToSwitchToActive),LOCATION_ENERGY,0,0,4,HINTMSG_TOACTIVE)
scard.op1=aux.TargetCardsOperation(Duel.SwitchtoActive,REASON_EFFECT)
