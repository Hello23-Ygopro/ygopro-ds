--BT1-048 Ultimate Judgment Jaco
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_JACO)
	aux.AddSpecialTrait(c,TRAIT_GALACTIC_PATROL)
	aux.AddEra(c,ERA_CHAMPA_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--return
	aux.AddSingleAutoSkill(c,0,EVENT_CUSTOM+EVENT_COMBO,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--return
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.ComboAreaFilter(Card.IsAbleToHand),0,LOCATION_COMBO,1,1,HINTMSG_RTOHAND)
scard.op1=aux.TargetSendtoHandOperation(nil)
