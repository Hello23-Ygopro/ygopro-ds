--P-037 Increasing Evil Frieza
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_FRIEZA)
	aux.AddSpecialTrait(c,TRAIT_FRIEZA_CLAN,TRAIT_FRIEZAS_ARMY)
	aux.AddEra(c,ERA_DARK_DEMON_REALM_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--xeno-evolve
	aux.EnableXenoEvolve(c,aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_FRIEZA),aux.PaySkillCost(COLOR_COLORLESS,0,6))
	--triple strike
	aux.EnableTripleStrike(c)
	--confirm hand, play
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,aux.EvolvePlayCondition)
end
scard.combo_cost=1
--confirm hand, play
function scard.conffilter(c,e)
	return not c:IsPublic() and c:IsCanBeEffectTarget(e)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	local g=Duel.GetMatchingGroup(aux.HandFilter(scard.conffilter),tp,0,LOCATION_HAND,nil,e)
	local sg=g:RandomSelect(tp,0,2)
	Duel.SetTargetCard(sg)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if not g then return end
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	Duel.ConfirmCards(1-tp,sg)
	for tc in aux.Next(sg) do
		if tc:IsBattle() then
			if Duel.PlayStep(tc,0,tp,1-tp,false,false,POS_FACEUP_ACTIVE) then
				--negate skill
				aux.AddTempSkillNegateSkill(e:GetHandler(),tc,1,0)
				Duel.PlayComplete()
			end
		elseif tc:IsExtra() then
			Duel.SendtoDrop(tc,REASON_EFFECT)
		end
	end
	Duel.ShuffleHand(1-tp)
end
