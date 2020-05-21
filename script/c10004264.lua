--TB2-060 Ginormous Strength Giran
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_GIRAN)
	aux.AddSpecialTrait(c,TRAIT_EARTHLING,TRAIT_WORLD_TOURNAMENT)
	aux.AddEra(c,ERA_WORLD_MA_TOURNAMENT_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--critical
	aux.EnableCritical(c)
	--tap, gain skill
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
scard.specified_cost={COLOR_YELLOW,2}
scard.combo_cost=0
--tap, gain skill
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(Card.IsEnergyBelow,4),0,LOCATION_BATTLE,0,1,HINTMSG_TARGET)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) then return end
	Duel.SwitchtoRest(tc,REASON_EFFECT)
	--cannot switch to active
	aux.AddTempSkillCustom(e:GetHandler(),tc,1,EFFECT_CANNOT_CHANGE_POS_E,RESET_PHASE+PHASE_DRAW+RESET_OPPO_TURN,1,aux.SelfRestCondition)
end
