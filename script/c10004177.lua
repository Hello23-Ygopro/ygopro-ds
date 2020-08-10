--EX03-23 Frieza, Obsession of The Clan
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_FRIEZA)
	aux.AddSpecialTrait(c,TRAIT_FRIEZA_CLAN,TRAIT_FRIEZAS_ARMY)
	aux.AddEra(c,ERA_FRIEZA_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--drop, negate attack
	aux.AddAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
--drop, negate attack
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	return tc and tc:IsControler(1-tp)
		and aux.SelfLeaderCondition(Card.IsSpecialTrait,TRAIT_FRIEZA_CLAN)(e,tp,eg,ep,ev,re,r,rp)
		and e:GetHandler():GetFlagEffect(sid)==0
end
function scard.dropfilter(c)
	return c:IsSpecialTrait(TRAIT_FRIEZA_CLAN) and not c:IsCharacter(CHARACTER_FRIEZA) and c:IsAbleToDrop()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DROP)
	local g=Duel.SelectMatchingCard(tp,aux.HandFilter(scard.dropfilter),tp,LOCATION_HAND,0,0,1,nil)
	if g:GetCount()==0 then return end
	Duel.SetTargetCard(g)
	if Duel.SendtoDrop(g,REASON_EFFECT)==0 then return end
	Duel.NegateAttack()
	--negate skill
	Duel.NegateEffect(0)
	c:RegisterFlagEffect(sid,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(sid,1))
end
