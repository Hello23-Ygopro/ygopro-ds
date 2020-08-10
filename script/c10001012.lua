--BT1-010 Divine Aide Vados
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_RED,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_VADOS)
	aux.AddSpecialTrait(c,TRAIT_GOD)
	aux.AddEra(c,ERA_CHAMPA_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--super combo
	aux.EnableSuperCombo(c)
	--draw, gain skill
	aux.AddSingleAutoSkill(c,0,EVENT_CUSTOM+EVENT_COMBO,nil,scard.op1,nil,scard.con1)
end
--draw, gain skill
scard.con1=aux.AND(aux.SelfLeaderCondition(Card.IsColor,COLOR_RED),aux.LifeEqualBelowCondition(PLAYER_SELF,4))
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	--gain combo power
	aux.AddTempSkillUpdateComboPower(c,c,1,10000)
end
