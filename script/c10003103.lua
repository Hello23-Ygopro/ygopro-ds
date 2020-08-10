--BT3-093 Lord of the Great Apes, King Vegeta
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_KING_VEGETA)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_BARDOCK_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--search (to hand)
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--search (to hand)
function scard.thfilter(c)
	return c:IsSpecialTrait(TRAIT_GREAT_APE) and c:IsEnergyBelow(5) and c:IsAbleToHand()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.thfilter,LOCATION_DECK,0,0,1,HINTMSG_ATOHAND)
scard.op1=aux.TargetSendtoHandOperation(true)
