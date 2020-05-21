--BT5-096 Bitter Past Ginyu
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_GINYU)
	aux.AddSpecialTrait(c,TRAIT_GINYU_FORCE,TRAIT_FRIEZAS_ARMY)
	aux.AddEra(c,ERA_RESURRECTION_F_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--barrier
	aux.EnableBarrier(c)
	--search (play)
	aux.AddActivateMainSkill(c,0,scard.op1,scard.cost1,scard.tg1,EFFECT_FLAG_CARD_TARGET)
end
scard.specified_cost={COLOR_YELLOW,1}
scard.combo_cost=0
--search (play)
scard.cost1=aux.MergeCost(aux.PaySkillCost(COLOR_YELLOW,3,0),aux.SelfDropCost)
function scard.playfilter(c,e,tp)
	return aux.IsCode(c,CARD_GINYU) and c:IsColor(COLOR_YELLOW)
		and c:IsEnergy(3) and c:IsCanBePlayed(e,0,tp,false,false)
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.playfilter,LOCATION_DECK,0,0,1,HINTMSG_PLAY)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e)
		and Duel.PlayStep(tc,0,tp,tp,false,false,POS_FACEUP_ACTIVE) and tc:IsCanBeEffectTarget(e) then
		Duel.BreakEffect()
		Duel.SetTargetCard(tc)
		--critical
		aux.AddTempSkillCritical(e:GetHandler(),tc,1)
		Duel.PlayComplete()
		Duel.ShuffleDeck(tp)
	end
	Duel.BreakEffect()
	Duel.Draw(tp,1,REASON_EFFECT)
end
