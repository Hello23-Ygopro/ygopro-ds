--BT3-010 Reliable Trunks
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_RED,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_TRUNKS_GT)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_BLACK_STAR_DRAGON_BALL_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_GT)
	--battle card
	aux.EnableBattleAttribute(c)
	--evolve
	aux.EnableEvolve(c,aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_TRUNKS_GT),aux.PaySkillCost(COLOR_RED,2,0))
	--critical
	aux.EnableCritical(c)
	--draw, gain skill
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,nil,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--draw, gain skill
function scard.powfilter(c,e)
	return (c:IsLeader() or c:IsBattle()) and c:IsColor(COLOR_RED) and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectMatchingCard(tp,aux.FaceupFilter(scard.powfilter),tp,LOCATION_INPLAY,0,0,1,nil,e)
	if g:GetCount()==0 then return end
	Duel.BreakEffect()
	Duel.SetTargetCard(g)
	--gain power
	aux.AddTempSkillUpdatePower(e:GetHandler(),g:GetFirst(),1,5000)
end
