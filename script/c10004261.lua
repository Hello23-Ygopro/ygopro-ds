--TB2-058 Unyielding Victory Jackie Chun
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_JACKIE_CHUN)
	aux.AddSpecialTrait(c,TRAIT_EARTHLING,TRAIT_WORLD_TOURNAMENT)
	aux.AddEra(c,ERA_WORLD_MA_TOURNAMENT_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--barrier
	aux.EnableBarrier(c)
	--ko, untap
	aux.AddAutoSkill(c,0,EVENT_PHASE+PHASE_END,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
scard.specified_cost={COLOR_YELLOW,2}
scard.combo_cost=1
--ko, untap
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
		and Duel.IsExistingTarget(aux.BattleAreaFilter(Card.IsCode,CARD_UNYIELDING_VICTORY_SON_GOKU),tp,LOCATION_BATTLE,0,1,nil)
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(Card.IsCode,CARD_UNYIELDING_VICTORY_SON_GOKU),LOCATION_BATTLE,0,1,1,HINTMSG_KO)
function scard.untfilter(c,e)
	return c:IsAbleToSwitchToActive() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) or Duel.KO(tc,REASON_EFFECT)==0 then return end
	local c=e:GetHandler()
	local g1=Group.CreateGroup()
	if c:IsCanBeEffectTarget(e) then
		g1:AddCard(c)
		Duel.SetTargetCard(g1)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOACTIVE)
	local g2=Duel.SelectMatchingCard(tp,aux.EnergyAreaFilter(scard.untfilter),tp,LOCATION_ENERGY,0,1,1,nil,e)
	if g2:GetCount()>0 then
		Duel.SetTargetCard(g2)
		g1:Merge(g2)
	end
	Duel.SwitchtoActive(g1,REASON_EFFECT)
end
