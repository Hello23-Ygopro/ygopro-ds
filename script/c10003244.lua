--TB1-082 Secret Vitality Jiren
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_JIREN)
	aux.AddSpecialTrait(c,TRAIT_ALIEN,TRAIT_PRIDE_TROOPERS,TRAIT_UNIVERSE_11)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,TRAIT_CATEGORY_UNIVERSE)
	--battle card
	aux.EnableBattleAttribute(c)
	--drop, ko
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,nil,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
--drop, ko
scard.con1=aux.SelfLeaderCondition(Card.IsSpecialTrait,TRAIT_UNIVERSE_11)
function scard.dropfilter(c)
	return c:IsColor(COLOR_YELLOW) and c:IsAbleToDrop()
end
function scard.kofilter(c,e)
	return c:IsRest() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DROP)
	local g1=Duel.SelectMatchingCard(tp,aux.HandFilter(scard.dropfilter),tp,LOCATION_HAND,0,0,1,nil)
	if g1:GetCount()==0 or Duel.SendtoDrop(g1,REASON_EFFECT)==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_KO)
	local g2=Duel.SelectMatchingCard(tp,aux.BattleAreaFilter(scard.kofilter),tp,0,LOCATION_BATTLE,0,2,nil,e)
	if g2:GetCount()==0 then return end
	Duel.SetTargetCard(g2)
	Duel.KO(g2,REASON_EFFECT)
end
