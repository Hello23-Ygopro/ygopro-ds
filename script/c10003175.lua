--TB1-022 Union Attack Botamo and Magetta
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_BOTAMO,CHARACTER_MAGETTA)
	aux.AddSpecialTrait(c,TRAIT_ALIEN,TRAIT_UNIVERSE_6)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,TRAIT_CATEGORY_UNIVERSE)
	--battle card
	aux.EnableBattleAttribute(c)
	--super combo
	aux.EnableSuperCombo(c)
	--draw, gain skill
	aux.AddSingleAutoSkill(c,0,EVENT_CUSTOM+EVENT_COMBO,nil,scard.op1,nil,scard.con1)
end
scard.specified_cost={COLOR_RED,2}
scard.combo_cost=0
--draw, gain skill
scard.con1=aux.AND(aux.SelfLeaderCondition(Card.IsSpecialTrait,TRAIT_UNIVERSE_6),aux.LifeEqualBelowCondition(PLAYER_SELF,5))
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	--gain combo power
	aux.AddTempSkillUpdateComboPower(c,c,1,10000)
end
