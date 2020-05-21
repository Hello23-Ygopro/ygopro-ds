--BT4-023 Iron Vow Trunks
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_TRUNKS_YOUTH)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_HIRUDEGARN_SAGA)
	--leader card
	aux.EnableLeaderAttribute(c)
	--draw
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,aux.DuelOperation(Duel.Draw,PLAYER_SELF,1,REASON_EFFECT))
	--untap
	aux.AddAutoSkill(c,1,EVENT_PHASE+PHASE_END,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
scard.front_side_code=sid-1
--untap
function scard.untfilter(c)
	return c:IsColor(COLOR_BLUE) and c:IsEnergyAbove(3) and c:IsAbleToSwitchToActive()
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
		and aux.EnergyExclusiveCondition(Card.IsColor,COLOR_BLUE)(e,tp,eg,ep,ev,re,r,rp)
		and (Duel.IsExistingTarget(aux.BattleAreaFilter(scard.untfilter),tp,LOCATION_BATTLE,0,1,nil)
		or Duel.IsExistingTarget(aux.EnergyAreaFilter(Card.IsAbleToSwitchToActive),tp,LOCATION_ENERGY,0,1,nil))
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOACTIVE)
	Duel.SelectTarget(tp,aux.BattleAreaFilter(scard.untfilter),tp,LOCATION_BATTLE,0,0,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOACTIVE)
	Duel.SelectTarget(tp,aux.EnergyAreaFilter(Card.IsAbleToSwitchToActive),tp,LOCATION_ENERGY,0,0,1,nil)
end
scard.op1=aux.TargetCardsOperation(Duel.SwitchtoActive,REASON_EFFECT)
