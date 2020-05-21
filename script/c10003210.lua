--TB1-052 Son Goku, Hope of Universe 7
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_SON_GOKU)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_UNIVERSE_7)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOKU,TRAIT_CATEGORY_UNIVERSE)
	--battle card
	aux.EnableBattleAttribute(c)
	--ex-evolve
	aux.EnableEXEvolve(c,scard.evofilter,scard.cost1)
	--triple attack
	aux.EnableTripleAttack(c)
	--critical
	aux.EnableCritical(c)
	--drop
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,scard.tg1,scard.op1,nil,aux.SelfLeaderCondition(Card.IsColor,COLOR_GREEN))
end
scard.specified_cost={COLOR_GREEN,3}
scard.combo_cost=1
--ex-evolve
function scard.evofilter(c)
	return c:IsSpecialTrait(TRAIT_UNIVERSE_7) and c:IsCharacter(CHARACTER_SON_GOKU) and c:IsEnergyAbove(5)
end
scard.cost1=aux.MergeCost(aux.PaySkillCost(COLOR_COLORLESS,0,1),aux.DropCost(aux.HandFilter(Card.IsSpecialTrait,TRAIT_UNIVERSE_7),LOCATION_HAND,0,2))
--drop
function scard.dropfilter(c,e)
	return c:IsAbleToDrop() and c:IsCanBeEffectTarget(e)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	local g1=Duel.GetMatchingGroup(aux.HandFilter(scard.dropfilter),tp,0,LOCATION_HAND,nil,e)
	local g2=Duel.GetMatchingGroup(aux.BattleAreaFilter(scard.dropfilter),tp,0,LOCATION_BATTLE,nil,e)
	g1:Merge(g2)
	if g1:GetCount()==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DROP)
	local sg=g1:Select(tp,0,1,nil)
	Duel.SetTargetCard(sg)
end
scard.op1=aux.TargetCardsOperation(Duel.SendtoDrop,REASON_EFFECT)
