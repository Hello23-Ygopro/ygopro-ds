--EX01-07 Psyched Up Gotenks
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_GOTENKS)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_MAJIN_BUU_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--union-fusion
	aux.EnableUnionFusion(c,scard.uniffilter1,scard.uniffilter2,aux.PaySkillCost(COLOR_GREEN,2,2))
	--double strike
	aux.EnableDoubleStrike(c)
	--draw, ko
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,nil,scard.op1)
end
scard.specified_cost={COLOR_GREEN,2}
scard.combo_cost=0
--union-fusion
scard.uniffilter1=aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_SON_GOTEN)
scard.uniffilter2=aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_TRUNKS_YOUTH)
--draw, ko
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsExistingMatchingCard(aux.DropAreaFilter(Card.IsCharacter,CHARACTER_SON_GOTEN),tp,LOCATION_DROP,0,1,nil) then
		Duel.Draw(tp,2,REASON_EFFECT)
	end
	if Duel.IsExistingMatchingCard(aux.DropAreaFilter(Card.IsCharacter,CHARACTER_TRUNKS_YOUTH),tp,LOCATION_DROP,0,1,nil) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_KO)
		local g=Duel.SelectMatchingCard(tp,aux.BattleAreaFilter(Card.IsCanBeEffectTarget),tp,0,LOCATION_BATTLE,0,1,nil,e)
		if g:GetCount()==0 then return end
		Duel.SetTargetCard(g)
		Duel.KO(g,REASON_EFFECT)
	end
end
