--BT4-013 Dependable Mom Bulma
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_BULMA_GT)
	aux.AddSpecialTrait(c,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_BABY_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_GT)
	--battle card
	aux.EnableBattleAttribute(c)
	--draw, gain skill
	aux.AddActivateMainSkill(c,0,scard.op1,aux.SelfSwitchtoRestCost,nil,EFFECT_FLAG_CARD_TARGET)
end
scard.specified_cost={COLOR_RED,1}
scard.combo_cost=0
--draw, gain skill
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectMatchingCard(tp,aux.BattleAreaFilter(Card.IsCanBeEffectTarget),tp,LOCATION_BATTLE,0,0,1,nil,e)
	if g:GetCount()==0 then return end
	Duel.BreakEffect()
	Duel.SetTargetCard(g)
	--gain power
	aux.AddTempSkillUpdatePower(e:GetHandler(),g:GetFirst(),1,5000)
end
