--BT2-048 Group Leader Pilaf
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_PILAF)
	aux.AddSpecialTrait(c,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_FUTURE_TRUNKS_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--play, negate skill
	aux.AddCounterBattleCardAttackSkill(c,0,scard.op1,nil,aux.SelfPlayTarget)
end
scard.specified_cost={COLOR_BLUE,1}
scard.combo_cost=0
--play, negate skill
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.Play(c,0,tp,tp,false,false,POS_FACEUP_ACTIVE)
	Duel.BreakEffect()
	local tc=Duel.GetAttacker()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_KEYSKILL)
	local code=Duel.SelectKeySkill(tp,tc)
	--negate skill
	Duel.NegateKeySkill(tc,code,RESET_PHASE+PHASE_END)
end
