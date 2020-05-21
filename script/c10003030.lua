--BT3-029 Baby's Subdual
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCategory(c,NAME_CATEGORY_BABY)
	--extra card
	aux.EnableExtraAttribute(c)
	--untap, gain skill, gain control
	aux.AddActivateMainSkill(c,0,scard.op1,nil,scard.tg1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
scard.specified_cost={COLOR_RED,3}
--untap, gain skill, gain control
scard.con1=aux.SelfLeaderCondition(Card.IsSpecialTrait,TRAIT_MACHINE_MUTANT)
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(Card.IsPowerBelow,15000),0,LOCATION_BATTLE,1,1,HINTMSG_TARGET)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SwitchtoActive(tc,REASON_EFFECT)
	end
	--gain power
	aux.AddTempSkillUpdatePower(e:GetHandler(),tc,1,5000)
	Duel.BreakEffect()
	Duel.GetControl(tc,tp)
end
