--BT5-024 Oolong's Wish
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_RED,1)
	--extra card
	aux.EnableExtraAttribute(c)
	--add special trait
	aux.AddPermanentAddSpecialTrait(c,TRAIT_DESIRE)
	--draw, gain skill
	aux.AddActivateMainSkill(c,0,scard.op1,nil,nil,EFFECT_FLAG_CARD_TARGET,aux.SelfLeaderCondition(Card.IsSpecialTrait,TRAIT_SHENRON))
end
--draw, gain skill
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectMatchingCard(tp,aux.BattleAreaFilter(Card.IsCanBeEffectTarget),tp,0,LOCATION_BATTLE,0,1,nil,e)
	if g:GetCount()==0 then return end
	Duel.BreakEffect()
	Duel.SetTargetCard(g)
	--lose power
	aux.AddTempSkillUpdatePower(e:GetHandler(),g:GetFirst(),1,-5000)
end
