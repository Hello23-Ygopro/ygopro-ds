--EX03-07 Explosive Power Vegeta
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_VEGETA)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_UNIVERSE_7)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,TRAIT_CATEGORY_UNIVERSE)
	--leader card
	aux.EnableLeaderAttribute(c)
	--warrior of universe 7
	aux.EnableWarriorofUniverse7(c)
	--gain power
	aux.AddPermanentUpdatePower(c,5000,scard.con1)
	--draw, to hand, charge
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
scard.front_side_code=sid-1
--gain power
function scard.con1(e)
	local tp=e:GetHandlerPlayer()
	return Duel.GetTurnPlayer()==tp
		and Duel.IsExistingMatchingCard(aux.EnergyAreaFilter(Card.IsSpecialTrait,TRAIT_UNIVERSE_7),tp,LOCATION_ENERGY,0,3,nil)
end
--draw, to hand, charge
function scard.thfilter(c,e)
	return c:IsAbleToHand() and c:IsCanBeEffectTarget(e)
end
function scard.tefilter(c,e)
	return c:IsAbleToEnergy() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g1=Duel.SelectMatchingCard(tp,aux.EnergyAreaFilter(scard.thfilter),tp,LOCATION_ENERGY,0,0,1,nil,e)
	if g1:GetCount()==0 then return end
	Duel.SetTargetCard(g1)
	if Duel.SendtoHand(g1,PLAYER_OWNER,REASON_EFFECT)==0 then return end
	Duel.ConfirmCards(1-tp,g1)
	Duel.ShuffleHand(tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOENERGY)
	local g2=Duel.SelectMatchingCard(tp,aux.HandFilter(scard.tefilter),tp,LOCATION_HAND,0,0,1,nil,e)
	if g2:GetCount()==0 then return end
	Duel.SetTargetCard(g2)
	Duel.SendtoEnergy(g2,POS_FACEUP_ACTIVE,REASON_EFFECT)
end
