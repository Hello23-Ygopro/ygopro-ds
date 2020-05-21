--P-070 Saiyan Power Baby
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_BABY,CHARACTER_VEGETA_GT)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_MACHINE_MUTANT)
	aux.AddEra(c,ERA_BABY_SAGA)
	aux.AddCategory(c,NAME_CATEGORY_BABY,CHAR_CATEGORY_GT)
	--leader card
	aux.EnableLeaderAttribute(c)
	--draw
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,aux.DuelOperation(Duel.Draw,PLAYER_SELF,1,REASON_EFFECT))
	--gain skill
	local e1=aux.AddActivateMainSkill(c,1,scard.op1,nil,scard.tg1,EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
end
scard.front_side_code=sid-1
--gain skill
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(nil),LOCATION_BATTLE,0,1,1,HINTMSG_TARGET)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc1=Duel.GetFirstTarget()
	if not tc1 or not tc1:IsRelateToEffect(e) or not tc1:IsFaceup() then return end
	local c=e:GetHandler()
	--lose power
	aux.AddTempSkillUpdatePower(c,tc1,2,-15000)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectMatchingCard(tp,aux.BattleAreaFilter(Card.IsCanBeEffectTarget),tp,0,LOCATION_BATTLE,0,2,nil,e)
	if g:GetCount()==0 then return end
	Duel.SetTargetCard(g)
	for tc2 in aux.Next(g) do
		--lose power
		aux.AddTempSkillUpdatePower(c,tc2,3,-10000)
	end
end
