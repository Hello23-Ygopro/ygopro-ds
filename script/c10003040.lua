--BT3-036 Final Explosion Prince of Destruction Vegeta
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_VEGETA)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_MAJIN_BUU_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--double strike
	aux.EnableDoubleStrike(c)
	--to deck, ko
	aux.AddSingleAutoSkill(c,0,EVENT_DAMAGE_STEP_END,nil,scard.op1,EFFECT_FLAG_CARD_TARGET,aux.SelfAttackerCondition)
end
--to deck, ko
function scard.kofilter(c,e,cost)
	return c:IsEnergyAbove(0) and c:IsEnergyBelow(cost) and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SendtoDeck(c,PLAYER_OWNER,SEQ_DECK_BOTTOM,REASON_EFFECT)
	local cost=5
	local f=aux.BattleAreaFilter(scard.kofilter)
	local g=Duel.GetMatchingGroup(f,tp,0,LOCATION_BATTLE,nil,e,cost)
	if g:GetCount()==0 then return end
	Duel.BreakEffect()
	local tg=Group.CreateGroup()
	repeat
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_KO)
		local tc=g:Select(tp,0,1,nil):GetFirst()
		if not tc then break end
		Duel.SetTargetCard(tc)
		g:RemoveCard(tc)
		tg:AddCard(tc)
		cost=cost-tc:GetEnergy()
		g=g:Filter(f,nil,e,cost)
	until cost<=0 or g:GetCount()==0
	Duel.KO(tg,REASON_EFFECT)
end
