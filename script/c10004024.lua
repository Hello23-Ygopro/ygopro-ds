--BT4-022 Vengeful Onslaught
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--extra card
	aux.EnableExtraAttribute(c)
	--untap, gain skill
	aux.AddActivateMainSkill(c,0,scard.op1,nil,scard.tg1,EFFECT_FLAG_CARD_TARGET,aux.SelfLeaderCondition(Card.IsSpecialTrait,TRAIT_MACHINE_MUTANT))
end
scard.specified_cost={COLOR_RED,1}
--untap, gain skill
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(Card.IsPowerBelow,15000),LOCATION_BATTLE,0,1,1,HINTMSG_TARGET)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) then return end
	Duel.SwitchtoActive(tc,REASON_EFFECT)
	--gain power
	aux.AddTempSkillUpdatePower(e:GetHandler(),tc,1,5000)
end
