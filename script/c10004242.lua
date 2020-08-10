--TB2-042 Honed Moves Yamcha
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_YAMCHA)
	aux.AddSpecialTrait(c,TRAIT_EARTHLING,TRAIT_WORLD_TOURNAMENT)
	aux.AddEra(c,ERA_WORLD_MA_TOURNAMENT_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--critical
	aux.EnableCritical(c)
	--to hand, drop
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--to hand, drop
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.LifeAreaFilter(Card.IsAbleToHand),LOCATION_LIFE,0,0,1,HINTMSG_ATOHAND)
function scard.dropfilter(c,e)
	return c:IsAbleToDrop() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) or Duel.SendtoHand(tc,PLAYER_OWNER,REASON_EFFECT)==0 then return end
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_DROP)
	local g=Duel.SelectMatchingCard(1-tp,aux.HandFilter(scard.dropfilter),1-tp,LOCATION_HAND,0,1,1,nil,e)
	if g:GetCount()==0 then return end
	Duel.SetTargetCard(g)
	Duel.SendtoDrop(g,REASON_EFFECT)
end
