--BT1-084 Frieza
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_FRIEZA)
	aux.AddSpecialTrait(c,TRAIT_FRIEZA_CLAN,TRAIT_FRIEZAS_ARMY)
	aux.AddEra(c,ERA_FRIEZA_SAGA)
	--leader card
	aux.EnableLeaderAttribute(c)
	--untap
	aux.AddAutoSkill(c,0,EVENT_PHASE+PHASE_END,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
	--awaken
	aux.EnableAwaken(c)
end
scard.back_side_code=sid+1
--untap
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
		and Duel.IsExistingTarget(aux.BattleAreaFilter(Card.IsAbleToSwitchToActive),tp,LOCATION_BATTLE,0,1,nil)
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(Card.IsAbleToSwitchToActive),LOCATION_BATTLE,0,0,1,HINTMSG_TOACTIVE)
scard.op1=aux.TargetCardsOperation(Duel.SwitchtoActive,REASON_EFFECT)
