--BT3-043 Powers Combined, Kibito Kai
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_KIBITO_KAI)
	aux.AddSpecialTrait(c,TRAIT_GOD)
	aux.AddEra(c,ERA_MAJIN_BUU_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--super combo
	aux.EnableSuperCombo(c)
	--return, gain skill, draw
	aux.AddSingleAutoSkill(c,0,EVENT_CUSTOM+EVENT_COMBO,nil,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
scard.specified_cost={COLOR_BLUE,1}
scard.combo_cost=0
--return, gain skill, draw
scard.con1=aux.AND(aux.SelfLeaderCondition(Card.IsColor,COLOR_BLUE),aux.LifeEqualBelowCondition(PLAYER_SELF,4))
function scard.retfilter(c,e)
	return c:IsAbleToHand() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	--gain combo power
	aux.AddTempSkillUpdateComboPower(c,c,1,10000)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectMatchingCard(tp,aux.ComboAreaFilter(scard.retfilter),tp,0,LOCATION_COMBO,0,1,nil,e)
	if g:GetCount()>0 then
		Duel.BreakEffect()
		Duel.SetTargetCard(g)
		Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
	if Duel.GetComboCount(1-tp)==0 then
		Duel.BreakEffect()
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
