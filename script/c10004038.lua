--BT4-034 Raging Energy Blast Gotenks
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_GOTENKS)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_HIRUDEGARN_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--critical
	aux.EnableCritical(c)
	--search (to hand), untap
	aux.AddActivateMainSkill(c,0,scard.op1,aux.SelfDropCost,scard.tg1,EFFECT_FLAG_CARD_TARGET)
end
--search (to hand), untap
function scard.thfilter(c,charname)
	return c:IsCharacter(charname) and c:IsAbleToHand()
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	Duel.SelectTarget(tp,scard.thfilter,tp,LOCATION_DECK,0,0,1,nil,CHARACTER_SON_GOTEN)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	Duel.SelectTarget(tp,scard.thfilter,tp,LOCATION_DECK,0,0,1,nil,CHARACTER_TRUNKS_YOUTH)
end
function scard.untfilter(c,e)
	return c:IsAbleToSwitchToActive() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if g1 then
		local sg=g1:Filter(Card.IsRelateToEffect,nil,e)
		Duel.SendtoHand(sg,PLAYER_OWNER,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOACTIVE)
	local g2=Duel.SelectMatchingCard(tp,aux.EnergyAreaFilter(scard.untfilter),tp,LOCATION_ENERGY,0,0,2,nil,e)
	if g2:GetCount()==0 then return end
	Duel.BreakEffect()
	Duel.SetTargetCard(g2)
	Duel.SwitchtoActive(g2,REASON_EFFECT)
end
