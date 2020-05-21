--BT2-095 Hidden Awakening Kale
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_KALE)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_ALIEN)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--critical
	aux.EnableCritical(c)
	--ko
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
	--draw
	aux.AddSingleAutoSkill(c,1,EVENT_ATTACK_ANNOUNCE,nil,aux.DuelOperation(Duel.Draw,PLAYER_SELF,1,REASON_EFFECT),nil,aux.HandEqualBelowCondition(PLAYER_SELF,5))
end
scard.specified_cost={COLOR_GREEN,2}
scard.combo_cost=0
--ko
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(nil),LOCATION_BATTLE,0,1,1,HINTMSG_KO)
function scard.kofilter(c,e,cost)
	return c:IsEnergyAbove(0) and c:IsEnergyBelow(cost) and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc1=Duel.GetFirstTarget()
	if tc1 and tc1:IsRelateToEffect(e) then
		Duel.KO(tc1,REASON_EFFECT)
	end
	local cost=5
	local f=aux.BattleAreaFilter(scard.kofilter)
	local g=Duel.GetMatchingGroup(f,tp,0,LOCATION_BATTLE,nil,e,cost)
	if g:GetCount()==0 then return end
	local tg=Group.CreateGroup()
	repeat
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_KO)
		local tc2=g:Select(tp,0,1,nil):GetFirst()
		if not tc2 then break end
		Duel.SetTargetCard(tc2)
		g:RemoveCard(tc2)
		tg:AddCard(tc2)
		cost=cost-tc2:GetEnergy()
		g=g:Filter(f,nil,e,cost)
	until cost<=0 or g:GetCount()==0
	Duel.BreakEffect()
	Duel.KO(tg,REASON_EFFECT)
end
