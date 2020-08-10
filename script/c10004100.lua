--BT4-090 Caring Mother Videl
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_VIDEL)
	aux.AddSpecialTrait(c,TRAIT_EARTHLING,TRAIT_GOKUS_LINEAGE)
	aux.AddEra(c,ERA_RESURRECTION_F_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--draw, gain skill
	aux.AddActivateMainSkill(c,0,scard.op1,aux.SelfSwitchtoRestCost,nil,EFFECT_FLAG_CARD_TARGET)
end
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
