--BT3-053 Rebirth of Justice
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,2)
	--extra card
	aux.EnableExtraAttribute(c)
	--play, return
	aux.AddActivateMainSkill(c,0,scard.op1,nil,scard.tg1,EFFECT_FLAG_CARD_TARGET)
end
--play, return
function scard.playfilter(c,e,tp)
	return c:IsBattle() and c:IsColor(COLOR_BLUE) and c:IsEnergyBelow(5) and c:IsCanBePlayed(e,0,tp,false,false)
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.playfilter,LOCATION_HAND,0,0,1,HINTMSG_PLAY)
function scard.thfilter(c,e)
	return c:IsAbleToHand() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.Play(tc,0,tp,tp,false,false,POS_FACEUP_ACTIVE)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectMatchingCard(tp,aux.BattleAreaFilter(scard.thfilter),tp,0,LOCATION_BATTLE,1,1,nil,e)
	if g:GetCount()==0 then return end
	Duel.BreakEffect()
	Duel.SetTargetCard(g)
	Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
end
