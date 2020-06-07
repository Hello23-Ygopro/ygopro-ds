--P-068 Broly, Legend's Dawning
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_BROLY)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_BROLY_SAGA)
	--leader card
	aux.EnableLeaderAttribute(c)
	--draw, drop
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.op1,EFFECT_FLAG_CARD_TARGET)
	--ko
	local e1=aux.AddActivateMainSkill(c,1,scard.op2,scard.cost1,scard.tg1,EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
end
scard.front_side_code=sid-1
--draw, drop
function scard.dropfilter1(c,e)
	return not c:IsToken() and not c:IsColor(COLOR_BLACK) and c:IsAbleToDrop() and c:IsCanBeEffectTarget(e)
end
function scard.dropfilter2(c,e)
	return c:IsAbleToDrop() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DROP)
	local g1=Duel.SelectMatchingCard(tp,aux.BattleAreaFilter(scard.dropfilter1),tp,LOCATION_BATTLE,0,0,1,nil,e)
	if g1:GetCount()==0 then return end
	Duel.BreakEffect()
	Duel.SetTargetCard(g1)
	if Duel.SendtoDrop(g1,REASON_EFFECT)==0 then return end
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_DROP)
	local g2=Duel.SelectMatchingCard(1-tp,aux.HandFilter(scard.dropfilter2),1-tp,LOCATION_HAND,0,1,1,nil,e)
	if g2:GetCount()==0 then return end
	Duel.SetTargetCard(g2)
	Duel.SendtoDrop(g2,REASON_EFFECT)
end
--ko
scard.cost1=aux.DropCost(aux.HandFilter(nil),LOCATION_HAND,0,1,1,true)
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(nil),0,LOCATION_BATTLE,0,1,HINTMSG_KO)
scard.op2=aux.TargetCardsOperation(Duel.KO,REASON_EFFECT)
