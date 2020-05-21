--BT3-103 Burgeoning Power Bergamo
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_BERGAMO)
	aux.AddSpecialTrait(c,TRAIT_ALIEN)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--drop, untap, gain skill
	aux.AddSingleAutoSkill(c,0,EVENT_DAMAGE_STEP_END,scard.tg1,scard.op1,nil,aux.TurnPlayerCondition(PLAYER_OPPO))
end
scard.specified_cost={COLOR_YELLOW,2}
scard.combo_cost=0
--drop, untap, gain skill
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tc=c:GetBattleTarget()
	if chk==0 then return c:IsOnField() and tc and tc:IsRelateToBattle() end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DROP)
	local g=Duel.SelectMatchingCard(tp,aux.HandFilter(Card.IsAbleToDrop),tp,LOCATION_HAND,0,0,1,nil)
	if g:GetCount()==0 or Duel.SendtoDrop(g,REASON_EFFECT)==0 then return end
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	Duel.SwitchtoActive(c,REASON_EFFECT)
	--gain power
	aux.AddTempSkillUpdatePower(c,c,1,5000)
end
