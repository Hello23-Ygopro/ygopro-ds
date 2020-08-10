--EX03-18 Elegant Assistance Heles
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_HELES)
	aux.AddSpecialTrait(c,TRAIT_GOD,TRAIT_UNIVERSE_2)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,TRAIT_CATEGORY_UNIVERSE)
	--battle card
	aux.EnableBattleAttribute(c)
	--super combo
	aux.EnableSuperCombo(c)
	--drop, draw, gain skill
	aux.AddSingleAutoSkill(c,0,EVENT_CUSTOM+EVENT_COMBO,nil,scard.op1,nil,scard.con1)
end
--drop, draw, gain skill
scard.con1=aux.AND(aux.SelfLeaderCondition(Card.IsSpecialTrait,TRAIT_GOD,TRAIT_UNIVERSE_2),aux.LifeEqualBelowCondition(PLAYER_SELF,4))
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DROP)
	local g=Duel.SelectMatchingCard(tp,aux.HandFilter(Card.IsAbleToDrop),tp,LOCATION_HAND,0,0,1,nil)
	if g:GetCount()==0 or Duel.SendtoDrop(g,REASON_EFFECT)==0 then return end
	Duel.Draw(tp,2,REASON_EFFECT)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	--gain combo power
	aux.AddTempSkillUpdateComboPower(c,c,1,10000)
end
