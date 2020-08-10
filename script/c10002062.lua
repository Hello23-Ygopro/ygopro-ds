--BT2-056 Zamasu, The Alert God
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,2)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_ZAMASU)
	aux.AddSpecialTrait(c,TRAIT_GOD)
	aux.AddEra(c,ERA_FUTURE_TRUNKS_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--evolve
	aux.EnableEvolve(c,aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_ZAMASU),aux.PaySkillCost(COLOR_BLUE,3,2))
	--indestructible
	aux.EnableIndestructible(c)
	--negate attack
	aux.AddAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.op1,nil,scard.con1)
end
--negate attack
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	return tc and tc:IsControler(1-tp)
		and aux.SelfLeaderCondition(Card.IsCharacter,CHARACTER_ZAMASU,CHARACTER_GOKU_BLACK)(e,tp,eg,ep,ev,re,r,rp)
		and Duel.IsExistingMatchingCard(aux.HandFilter(Card.IsAbleToDrop),tp,LOCATION_HAND,0,1,nil)
		and e:GetHandler():GetFlagEffect(sid)==0
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DROP)
	local g=Duel.SelectMatchingCard(tp,aux.HandFilter(Card.IsAbleToDrop),tp,LOCATION_HAND,0,0,1,nil)
	if g:GetCount()==0 or Duel.SendtoDrop(g,REASON_EFFECT)==0 then return end
	Duel.NegateAttack()
	--negate skill
	Duel.NegateEffect(0)
	c:RegisterFlagEffect(sid,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(sid,1))
end
