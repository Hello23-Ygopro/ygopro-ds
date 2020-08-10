--BT5-048 Phantom Strike Janemba
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,4)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_JANEMBA)
	aux.AddSpecialTrait(c,TRAIT_EVIL_INCARNATE)
	aux.AddEra(c,ERA_JANEMBA_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--critical
	aux.EnableCritical(c)
	--warp, to hand
	aux.AddSingleAutoSkill(c,0,EVENT_WARP,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
	--play
	aux.AddActivateMainSkill(c,1,scard.op2,aux.SelfSendtoWarpCost,scard.tg2,EFFECT_FLAG_CARD_TARGET)
end
--warp, to hand
scard.con1=aux.SelfPreviousLocationCondition(LOCATION_BATTLE)
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(Card.IsAbleToWarp),0,LOCATION_BATTLE,0,1,HINTMSG_WARP)
function scard.thfilter(c)
	return c:IsCharacter(CHARACTER_JANEMBA) and c:IsAbleToHand()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SendtoWarp(tc,REASON_EFFECT)
	end
	local g=Duel.GetFieldGroup(tp,LOCATION_DECK,0):GetMinGroup(Card.GetSequence)
	if g:GetCount()==0 then return end
	Duel.BreakEffect()
	Duel.ConfirmCards(tp,g)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local sg=g:FilterSelect(tp,scard.thfilter,0,1,nil)
	if sg:GetCount()>0 then
		Duel.SendtoHand(sg,PLAYER_OWNER,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
	end
	Duel.ShuffleDeck(tp)
end
--play
function scard.playfilter(c,e,tp)
	return c:IsCharacter(CHARACTER_JANEMBA) and c:IsEnergy(5) and c:IsCanBePlayed(e,0,tp,false,false)
end
function scard.con2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetEnergyCount(1-tp)>=4
		and not Duel.IsExistingMatchingCard(aux.BattleAreaFilter(Card.IsCharacter,CHARACTER_JANEMBA),tp,LOCATION_BATTLE,0,1,nil)
end
scard.tg2=aux.TargetCardFunction(PLAYER_SELF,aux.HandFilter(scard.playfilter),LOCATION_HAND,0,0,1,HINTMSG_PLAY,scard.con2)
scard.op2=aux.TargetPlayOperation(POS_FACEUP_ACTIVE)
