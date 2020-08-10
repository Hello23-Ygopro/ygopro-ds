--BT3-022 Commander Nezi
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_RED,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_NEZI)
	aux.AddSpecialTrait(c,TRAIT_MACHINE_MUTANT)
	aux.AddEra(c,ERA_BLACK_STAR_DRAGON_BALL_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--union-absorb
	aux.EnableUnionAbsorb(c,aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_SUPER_SIGMA),scard.cost1)
	--search (to hand)
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
--union-absorb
function scard.costfilter(c,charname)
	return c:IsCharacter(charname) and (aux.HandFilter(nil) or aux.BattleAreaFilter(nil))
end
function scard.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(scard.costfilter,tp,LOCATION_HAND+LOCATION_BATTLE,0,1,nil,CHARACTER_BIZU)
		and Duel.IsExistingTarget(scard.costfilter,tp,LOCATION_HAND+LOCATION_BATTLE,0,1,nil,CHARACTER_RIBET) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ABSORB)
	local g1=Duel.SelectTarget(tp,scard.costfilter,tp,LOCATION_HAND+LOCATION_BATTLE,0,1,1,nil,CHARACTER_BIZU)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ABSORB)
	local g2=Duel.SelectTarget(tp,scard.costfilter,tp,LOCATION_HAND+LOCATION_BATTLE,0,1,1,nil,CHARACTER_RIBET)
	g1:Merge(g2)
	Duel.PlaceUnder(e:GetHandler(),g1)
	Duel.ClearTargetCard()
end
--search (to hand)
scard.con1=aux.SelfLeaderCondition(Card.IsCharacter,CHARACTER_DR_MYUU)
function scard.thfilter(c)
	return c:IsCharacter(CHARACTER_NATT) and c:IsAbleToHand()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.thfilter,LOCATION_DECK,0,0,1,HINTMSG_ATOHAND)
scard.op1=aux.TargetSendtoHandOperation(true)
