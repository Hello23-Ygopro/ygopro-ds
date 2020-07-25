--BT5-022_SPR King Piccolo, Terror Unleashed (Alias)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_KING_PICCOLO)
	aux.AddSpecialTrait(c,TRAIT_NAMEKIAN)
	aux.AddEra(c,ERA_KING_PICCOLO_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--double strike
	aux.EnableDoubleStrike(c)
	--reduce energy cost
	aux.AddPermanentUpdateEnergyCost(c,-1,nil,aux.ExistingCardCondition(aux.DropAreaFilter(Card.IsCode,CARD_A_KINGS_RETURN_TO_YOUTH),LOCATION_DROP))
	--sparking (untap)
	aux.EnableSparking(c)
	local e1=aux.AddActivateMainSkill(c,0,scard.op1,scard.cost1,nil,EFFECT_FLAG_CARD_TARGET,aux.SparkingCondition(10))
	e1:SetCountLimit(1)
end
scard.specified_cost={COLOR_RED,2}
scard.combo_cost=1
--sparking (untap)
function scard.costfilter(c)
	return c:IsCode(CARD_KING_PICCOLO_TERROR_UNLEASHED,CARD_A_KINGS_RETURN_TO_YOUTH) and c:IsAbleToWarp()
end
scard.cost1=aux.SendtoWarpCost(aux.DropAreaFilter(scard.costfilter),LOCATION_DROP,0,1)
function scard.lfilter(c)
	return c:IsColor(COLOR_RED) and c:IsSpecialTrait(TRAIT_SHENRON)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() and aux.SelfLeaderCondition(scard.lfilter)(e,tp,eg,ep,ev,re,r,rp) then
		Duel.SwitchtoActive(c,REASON_EFFECT)
	end
end
