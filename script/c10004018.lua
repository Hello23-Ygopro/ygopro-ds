--BT4-016 Epochal Grudge Great Ape Baby
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_RED,3)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_BABY)
	aux.AddSpecialTrait(c,TRAIT_MACHINE_MUTANT,TRAIT_GREAT_APE,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_BABY_SAGA)
	aux.AddCategory(c,NAME_CATEGORY_BABY)
	--battle card
	aux.EnableBattleAttribute(c)
	--evolve
	aux.EnableEvolve(c,aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_BABY),aux.PaySkillCost(COLOR_RED,2,2))
	--triple strike
	aux.EnableTripleStrike(c)
	--draw, gain skill
	local e1=aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
	e1:SetCountLimit(1)
	local e2=aux.AddAutoSkill(c,0,EVENT_PLAY,nil,scard.op2,EFFECT_FLAG_CARD_TARGET,scard.con2)
	e2:SetCountLimit(1)
end
--draw, gain skill
scard.con1=aux.SelfLeaderCondition(Card.IsSpecialTrait,TRAIT_MACHINE_MUTANT)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	scard.apply_skill(e,tp)
end
function scard.con2(e,tp,eg,ep,ev,re,r,rp)
	return scard.con1(e,tp,eg,ep,ev,re,r,rp)
		and eg:IsExists(aux.BattleAreaFilter(aux.FilterEqualFunction(Card.GetPlayPlayer,1-tp)),1,nil)
end
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		scard.apply_skill(e,tp)
	end
end
function scard.apply_skill(e,tp)
	Duel.Draw(tp,1,REASON_EFFECT)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectMatchingCard(tp,aux.BattleAreaFilter(Card.IsCanBeEffectTarget),tp,0,LOCATION_BATTLE,0,1,nil,e)
	if g:GetCount()==0 then return end
	Duel.BreakEffect()
	Duel.SetTargetCard(g)
	--lose power
	aux.AddTempSkillUpdatePower(e:GetHandler(),g:GetFirst(),1,-20000)
end
