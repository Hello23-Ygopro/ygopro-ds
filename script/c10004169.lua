--EX03-16 Deathless Warrior Broly
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_BROLY)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_BROLY_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--evolve
	aux.EnableEvolve(c,aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_BROLY),aux.PaySkillCost(COLOR_GREEN,3,0))
	--reduce skill cost
	aux.AddPermanentUpdateSkillCost(c,-2,COLOR_GREEN,LOCATION_HAND,0,scard.tg1,aux.SelfEvolvingCondition)
	--ko or drop
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg2,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
scard.specified_cost={COLOR_GREEN,2}
scard.combo_cost=0
--reduce skill cost
function scard.tg1(e,c)
	return c~=e:GetHandler() and c:IsCharacter(CHARACTER_BROLY) and c:IsHasEffect(EFFECT_EVOLVE)
end
--ko or drop
scard.con1=aux.SelfLeaderCondition(Card.IsCharacter,CHARACTER_BROLY)
scard.tg2=aux.TargetCardFunction(PLAYER_OPPO,aux.BattleAreaFilter(nil),0,LOCATION_BATTLE,0,1,HINTMSG_KO)
function scard.dropfilter(c,e)
	return c:IsAbleToDrop() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and Duel.KO(tc,REASON_EFFECT)>0 then return end
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_DROP)
	local g=Duel.SelectMatchingCard(1-tp,aux.HandFilter(scard.dropfilter),1-tp,LOCATION_HAND,0,2,2,nil,e)
	if g:GetCount()==0 then return end
	Duel.SetTargetCard(g)
	Duel.SendtoDrop(g,REASON_EFFECT)
end
