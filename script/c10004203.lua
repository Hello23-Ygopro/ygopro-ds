--TB2-008 Mighty Mask, Powers Combined
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_MIGHTY_MASK)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_EARTHLING,TRAIT_WORLD_TOURNAMENT)
	aux.AddEra(c,ERA_THE_EVIL_WIZARD_BABIDI_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--super combo
	aux.EnableSuperCombo(c)
	--drop, gain skill, search (to hand)
	aux.AddSingleAutoSkill(c,0,EVENT_CUSTOM+EVENT_COMBO,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
scard.specified_cost={COLOR_RED,2}
scard.combo_cost=0
--drop, gain skill, search (to hand)
scard.con1=aux.AND(aux.SelfLeaderCondition(Card.IsColor,COLOR_RED),aux.LifeEqualBelowCondition(PLAYER_SELF,4))
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.HandFilter(Card.IsAbleToDrop),LOCATION_HAND,0,0,1,HINTMSG_DROP)
function scard.thfilter(c,e,charname)
	return c:IsColor(COLOR_RED) and c:IsCharacter(charname)
		and c:IsPowerBelow(15000) and c:IsAbleToHand() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) or Duel.SendtoDrop(tc,REASON_EFFECT)==0 then return end
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	--gain combo power
	aux.AddTempSkillUpdateComboPower(c,c,1,10000)
	Duel.BreakEffect()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g1=Duel.SelectMatchingCard(tp,scard.thfilter,tp,LOCATION_DECK,0,0,1,nil,e,CHARACTER_SON_GOTEN)
	Duel.SetTargetCard(g1)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g2=Duel.SelectMatchingCard(tp,scard.thfilter,tp,LOCATION_DECK,0,0,1,nil,e,CHARACTER_TRUNKS_YOUTH)
	Duel.SetTargetCard(g2)
	g1:Merge(g2)
	if g1:GetCount()==0 then return end
	Duel.SendtoHand(g1,PLAYER_OWNER,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,g1)
end
