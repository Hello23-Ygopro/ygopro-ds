--BT1-053 Senzu Bean
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,1)
	--extra card
	aux.EnableExtraAttribute(c)
	--gain skill, untap
	aux.AddActivateBattleSkill(c,0,scard.op1,nil,scard.tg1,EFFECT_FLAG_CARD_TARGET)
end
--gain skill, untap
function scard.powfilter(c)
	return c:IsLeader() or c:IsBattle()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.FaceupFilter(scard.powfilter),LOCATION_INPLAY,0,0,1,HINTMSG_TARGET)
function scard.untfilter(c,e)
	return c:IsAbleToSwitchToActive() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		--gain power
		aux.AddTempSkillUpdatePower(e:GetHandler(),tc,1,5000)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOACTIVE)
	local g=Duel.SelectMatchingCard(tp,aux.EnergyAreaFilter(scard.untfilter),tp,LOCATION_ENERGY,0,0,2,nil,e)
	if g:GetCount()==0 then return end
	Duel.BreakEffect()
	Duel.SetTargetCard(g)
	Duel.SwitchtoActive(g,REASON_EFFECT)
end
