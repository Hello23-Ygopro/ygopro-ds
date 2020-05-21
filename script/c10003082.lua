--BT3-075 Terror Scythe Goku Black
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_GOKU_BLACK)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_GOD)
	aux.AddEra(c,ERA_FUTURE_TRUNKS_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--token, search (to hand), drop
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,nil,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
scard.specified_cost={COLOR_GREEN,2}
scard.combo_cost=0
--token, search (to hand), drop
function scard.thfilter(c,e)
	return c:IsCharacter(CHARACTER_ZAMASU) and c:IsAbleToHand() and c:IsCanBeEffectTarget(e)
end
function scard.dropfilter(c,e)
	return c:IsAbleToDrop() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsPlayerCanPlayToken(tp,CARD_BT2014_SHADOW_TOKEN,0,TYPE_BATTLE,10000,5000,ENERGY_NONE,0,COLOR_NONE) then return end
	for i=1,2 do
		local token=Duel.CreateToken(tp,CARD_BT2014_SHADOW_TOKEN-1+i)
		Duel.PlayStep(token,0,tp,tp,false,false,POS_FACEUP_ACTIVE)
	end
	Duel.PlayComplete()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g1=Duel.SelectMatchingCard(tp,scard.thfilter,tp,LOCATION_DECK,0,0,1,nil,e)
	if g1:GetCount()==0 then return end
	Duel.BreakEffect()
	Duel.SetTargetCard(g1)
	if Duel.SendtoHand(g1,PLAYER_OWNER,REASON_EFFECT)==0 then return end
	Duel.ConfirmCards(1-tp,g1)
	Duel.ShuffleHand(tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DROP)
	local g2=Duel.SelectMatchingCard(tp,aux.HandFilter(scard.dropfilter),tp,LOCATION_HAND,0,1,1,nil,e)
	if g2:GetCount()==0 then return end
	Duel.SetTargetCard(g2)
	Duel.SendtoDrop(g2,REASON_EFFECT)
end
