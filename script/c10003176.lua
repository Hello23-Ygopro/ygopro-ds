--TB1-023 Strategies of Universe 7
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--extra card
	aux.EnableExtraAttribute(c)
	--gain skill
	aux.AddActivateMainSkill(c,0,scard.op1,nil,scard.tg1,EFFECT_FLAG_CARD_TARGET)
end
--gain skill
function scard.skfilter(c,e)
	return c:IsColor(COLOR_RED) and c:IsSpecialTrait(TRAIT_SAIYAN) and c:IsCanBeEffectTarget(e)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	local g=Duel.GetMatchingGroup(aux.BattleAreaFilter(scard.skfilter),tp,LOCATION_BATTLE,0,nil,e)
	Duel.SetTargetCard(g)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if not g then return end
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	local reset_count=(Duel.GetTurnPlayer()~=tp and 2 or 1)
	for tc in aux.Next(sg) do
		--barrier
		aux.AddTempSkillBarrier(e:GetHandler(),tc,1,RESET_PHASE+PHASE_END+RESET_OPPO_TURN,reset_count)
	end
end
