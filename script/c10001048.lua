--BT1-041 Beerus, General of Demolition
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,3)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_BEERUS)
	aux.AddSpecialTrait(c,TRAIT_GOD)
	aux.AddEra(c,ERA_RESURRECTION_F_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--triple strike
	aux.EnableTripleStrike(c)
	--drop
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.op1,EFFECT_FLAG_CARD_TARGET,aux.SelfAttackTargetCondition(Card.IsLeader))
end
--drop
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(aux.HandFilter(Card.IsAbleToDrop),tp,0,LOCATION_HAND,nil)
	if g:GetCount()>0 and Duel.SelectYesNo(1-tp,YESNOMSG_DROP) then
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_DROP)
		local sg=g:Select(1-tp,2,2,nil)
		if Duel.SendtoDrop(sg,REASON_EFFECT)~=2 then
			scard.drop(e,tp)
		end
	else scard.drop(e,tp) end
end
function scard.dropfilter(c,e)
	return c:IsAbleToDrop() and c:IsCanBeEffectTarget(e)
end
function scard.drop(e,tp)
	local g1=Duel.GetMatchingGroup(aux.BattleAreaFilter(scard.dropfilter),tp,0,LOCATION_BATTLE,nil,e)
	local g2=Duel.GetMatchingGroup(aux.EnergyAreaFilter(scard.dropfilter),tp,0,LOCATION_ENERGY,nil,e)
	g1:Merge(g2)
	Duel.SetTargetCard(g1)
	Duel.SendtoDrop(g1,REASON_EFFECT)
end
