--TB1-053 Destructo Disk Krillin
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_KRILLIN)
	aux.AddSpecialTrait(c,TRAIT_EARTHLING,TRAIT_UNIVERSE_7)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,TRAIT_CATEGORY_UNIVERSE)
	--battle card
	aux.EnableBattleAttribute(c)
	--to hand, ko
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
--to hand, ko
scard.con1=aux.SelfLeaderCondition(Card.IsSpecialTrait,TRAIT_UNIVERSE_7)
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.LifeAreaFilter(Card.IsAbleToHand),LOCATION_LIFE,0,1,1,HINTMSG_ATOHAND)
function scard.kofilter(c,e,cost)
	return c:IsEnergyAbove(0) and c:IsEnergyBelow(cost) and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc1=Duel.GetFirstTarget()
	if not tc1 or not tc1:IsRelateToEffect(e) or Duel.SendtoHand(tc1,PLAYER_OWNER,REASON_EFFECT)==0 then return end
	local cost=3
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
