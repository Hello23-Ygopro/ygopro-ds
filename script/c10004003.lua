--BT4-002 Rampaging Great Ape Baby
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_BABY)
	aux.AddSpecialTrait(c,TRAIT_MACHINE_MUTANT,TRAIT_GREAT_APE,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_BABY_SAGA)
	aux.AddCategory(c,NAME_CATEGORY_BABY)
	--leader card
	aux.EnableLeaderAttribute(c)
	--draw, gain skill
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.op1)
end
scard.front_side_code=sid-1
--draw, gain skill
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g1=Duel.SelectMatchingCard(tp,aux.BattleAreaFilter(Card.IsCanBeEffectTarget),tp,LOCATION_BATTLE,0,1,1,nil,e)
	if g1:GetCount()>0 then
		Duel.SetTargetCard(g1)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g2=Duel.SelectMatchingCard(tp,aux.BattleAreaFilter(Card.IsCanBeEffectTarget),tp,0,LOCATION_BATTLE,1,1,nil,e)
	if g2:GetCount()>0 then
		Duel.SetTargetCard(g2)
		g1:Merge(g2)
	end
	if not g1:IsExists(Card.IsRelateToEffect,1,nil,e) then return end
	Duel.BreakEffect()
	for tc in aux.Next(g1) do
		--lose power
		aux.AddTempSkillUpdatePower(e:GetHandler(),tc,1,-10000)
	end
end
