--BT3-042 Kibito, Kai's Attendant
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_KIBITO)
	aux.AddSpecialTrait(c,TRAIT_GOD)
	aux.AddEra(c,ERA_MAJIN_BUU_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--return
	aux.AddActivateMainSkill(c,0,scard.op1,aux.SelfSwitchtoRestCost,scard.tg1,EFFECT_FLAG_CARD_TARGET)
end
--return
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(Card.IsAbleToHand),LOCATION_BATTLE,0,1,1,HINTMSG_RTOHAND)
function scard.thfilter(c,e)
	return c:IsEnergyBelow(3) and c:IsAbleToHand() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,PLAYER_OWNER,REASON_EFFECT)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectMatchingCard(tp,aux.BattleAreaFilter(scard.thfilter),tp,0,LOCATION_BATTLE,0,1,nil,e)
	if g:GetCount()==0 then return end
	Duel.BreakEffect()
	Duel.SetTargetCard(g)
	Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
end
