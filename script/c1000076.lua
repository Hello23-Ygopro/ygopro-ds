--P-068 Broly
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_BROLY)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_BROLY_SAGA)
	--leader card
	aux.EnableLeaderAttribute(c)
	--drop
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,aux.SelfAttackTargetCondition(Card.IsLeader))
	--awaken
	aux.EnableAwaken(c)
end
scard.back_side_code=sid+1
--drop
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.LifeAreaFilter(Card.IsAbleToDrop),LOCATION_LIFE,0,0,1,HINTMSG_DROP)
function scard.dropfilter(c)
	return c:IsAbleToDrop() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) or Duel.SendtoDrop(tc,REASON_EFFECT)==0 then return end
	Duel.SendDecktoDropUpTo(tp,3,REASON_EFFECT)
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_DROP)
	local g=Duel.SelectMatchingCard(1-tp,aux.HandFilter(scard.dropfilter),1-tp,LOCATION_HAND,0,1,1,nil,e)
	if g:GetCount()==0 then return end
	Duel.BreakEffect()
	Duel.SetTargetCard(g)
	Duel.SendtoDrop(g,REASON_EFFECT)
end
