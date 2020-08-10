--SD4-05 Namekian Bond Saonel
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_SAONEL)
	aux.AddSpecialTrait(c,TRAIT_NAMEKIAN,TRAIT_ALIEN,TRAIT_UNIVERSE_6)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,TRAIT_CATEGORY_UNIVERSE)
	--battle card
	aux.EnableBattleAttribute(c)
	--bond (draw, to hand, ko)
	aux.EnableBond(c)
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,nil,scard.op1,EFFECT_FLAG_CARD_TARGET,aux.BondCondition(3,Card.IsSpecialTrait,TRAIT_NAMEKIAN))
end
--bond (draw, to hand, ko)
function scard.thfilter(c,e)
	return c:IsAbleToHand() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g1=Duel.SelectMatchingCard(tp,aux.LifeAreaFilter(scard.thfilter),tp,LOCATION_LIFE,0,0,2,nil,e)
	if g1:GetCount()==0 then return end
	Duel.BreakEffect()
	Duel.SetTargetCard(g1)
	if Duel.SendtoHand(g1,PLAYER_OWNER,REASON_EFFECT)==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_KO)
	local g2=Duel.SelectMatchingCard(tp,aux.BattleAreaFilter(Card.IsCanBeEffectTarget),tp,0,LOCATION_BATTLE,0,1,nil,e)
	if g2:GetCount()==0 then return end
	Duel.SetTargetCard(g2)
	Duel.KO(g2,REASON_EFFECT)
end
