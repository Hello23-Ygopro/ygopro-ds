--TB2-045_SPR Destined Conclusion Hero (Alias)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_HERO)
	aux.AddSpecialTrait(c,TRAIT_EARTHLING,TRAIT_GOD,TRAIT_WORLD_TOURNAMENT)
	aux.AddEra(c,ERA_WORLD_MA_TOURNAMENT_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--barrier
	aux.EnableBarrier(c)
	--gain skill, drop
	aux.AddAutoSkill(c,0,EVENT_PLAY,nil,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
scard.specified_cost={COLOR_GREEN,2}
scard.combo_cost=0
--gain skill, drop
function scard.cfilter(c,tp)
	return c:IsCode(CARD_DESTINED_CONCLUSION_PICCOLO_JR)
		and c:IsPreviousLocation(LOCATION_HAND) and c:GetPreviousControler()==tp
end
function scard.lfilter(c)
	return c:IsColor(COLOR_GREEN) and c:IsSpecialTrait(TRAIT_WORLD_TOURNAMENT)
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(aux.BattleAreaFilter(scard.cfilter),1,nil,tp)
		and aux.SelfLeaderCondition(scard.lfilter)(e,tp,eg,ep,ev,re,r,rp)
end
function scard.dropfilter(c,e)
	return c:IsAbleToDrop() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		--gain power
		aux.AddTempSkillUpdatePower(c,c,1,10000)
		--critical
		aux.AddTempSkillCritical(c,c,2)
	end
	if Duel.GetFlagEffect(tp,sid)>0 then return end
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_DROP)
	local g=Duel.SelectMatchingCard(1-tp,aux.HandFilter(scard.dropfilter),1-tp,LOCATION_HAND,0,3,3,nil,e)
	if g:GetCount()>0 then
		Duel.BreakEffect()
		Duel.SetTargetCard(g)
		Duel.SendtoDrop(g,REASON_EFFECT)
	end
	Duel.RegisterFlagEffect(tp,sid,RESET_PHASE+PHASE_END,0,1)
end
