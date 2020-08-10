--TB2-062 Risqué Ranfan
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_RANFAN)
	aux.AddSpecialTrait(c,TRAIT_EARTHLING,TRAIT_WORLD_TOURNAMENT)
	aux.AddEra(c,ERA_WORLD_MA_TOURNAMENT_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--tap, gain skill
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--tap, gain skill
function scard.tapfilter(c)
	return c:IsEnergyBelow(3) and c:IsAbleToSwitchToRest()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(scard.tapfilter),0,LOCATION_BATTLE,0,1,HINTMSG_TOREST)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SwitchtoRest(tc,REASON_EFFECT)
	end
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	--gain power
	aux.AddTempSkillUpdatePower(c,c,1,5000)
end
