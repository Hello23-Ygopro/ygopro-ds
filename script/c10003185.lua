--TB1-030 Beerus, Universe 7 Divine Vanquisher
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_BEERUS)
	aux.AddSpecialTrait(c,TRAIT_GOD,TRAIT_UNIVERSE_7)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,TRAIT_CATEGORY_UNIVERSE)
	--battle card
	aux.EnableBattleAttribute(c)
	--double strike
	aux.EnableDoubleStrike(c)
	--drop
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,aux.SelfAttackTargetCondition(Card.IsLeader))
end
scard.specified_cost={COLOR_BLUE,2}
scard.combo_cost=1
--drop
function scard.dropfilter(c,e)
	return not c:IsLeader() and c:IsEnergyAbove(0) and c:IsAbleToDrop() and c:IsCanBeEffectTarget(e)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	local g1=Duel.GetMatchingGroup(scard.dropfilter,tp,0,LOCATION_BATTLE,nil,e)
	local g2=Duel.GetMatchingGroup(aux.EnergyAreaFilter(scard.dropfilter),tp,0,LOCATION_ENERGY,nil,e)
	g1:Merge(g2)
	local sum=g1:GetSum(Card.GetEnergy) --only count the total energy cost that is public knowledge
	if g1:GetCount()==0 or sum<6 then return end
	local g3=Duel.GetMatchingGroup(aux.HandFilter(scard.dropfilter),tp,0,LOCATION_HAND,nil,e)
	g1:Merge(g3)
	local cost=0
	repeat
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_DROP)
		local tc=g1:Select(1-tp,1,1,nil):GetFirst()
		if not tc then break end
		Duel.SetTargetCard(tc)
		g1:RemoveCard(tc)
		cost=cost+tc:GetEnergy()
	until cost>=6 or g1:GetCount()==0 or g2:GetCount()==0
end
scard.op1=aux.TargetCardsOperation(Duel.SendtoDrop,REASON_EFFECT)
