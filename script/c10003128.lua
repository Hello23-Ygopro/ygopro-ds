--BT3-116 Dimension Breaker Mira
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_MIRA)
	aux.AddSpecialTrait(c,TRAIT_ANDROID)
	aux.AddEra(c,ERA_DARK_DEMON_REALM_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--xeno-evolve
	aux.EnableXenoEvolve(c,aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_MIRA),aux.PaySkillCost(COLOR_COLORLESS,0,5))
	--double strike
	aux.EnableDoubleStrike(c)
	--warp
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
--warp
scard.con1=aux.AND(aux.EvolvePlayCondition,aux.WarpEqualAboveCondition(PLAYER_SELF,5))
function scard.warpfilter(c,e)
	return c:IsAbleToWarp() and c:IsCanBeEffectTarget(e)
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(Card.IsAbleToWarp),0,LOCATION_BATTLE,0,1,HINTMSG_WARP)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SendtoWarp(tc,REASON_EFFECT)
	end
	local g=Duel.GetMatchingGroup(aux.EnergyAreaFilter(scard.warpfilter),tp,0,LOCATION_ENERGY,nil,e)
	if g:GetCount()==0 or Duel.GetWarpCount(tp)<10 then return end
	Duel.BreakEffect()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_WARP)
	local sg=g:Select(tp,0,1,nil)
	Duel.SetTargetCard(sg)
	Duel.SendtoWarp(sg,REASON_EFFECT)
end
