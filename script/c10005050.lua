--BT5-043 West Kai, Keeping Watch
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_WEST_KAI)
	aux.AddSpecialTrait(c,TRAIT_GOD)
	aux.AddEra(c,ERA_JANEMBA_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--barrier
	aux.EnableBarrier(c)
	--return
	aux.AddSingleAutoSkill(c,0,EVENT_CUSTOM+EVENT_COMBO,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--return
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.ComboAreaFilter(Card.IsAbleToHand),0,LOCATION_COMBO,0,1,HINTMSG_RTOHAND)
scard.op1=aux.TargetSendtoHandOperation(nil)
