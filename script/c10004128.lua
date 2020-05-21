--BT4-115 Frigid Blast Putine
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_PUTINE)
	aux.AddSpecialTrait(c,TRAIT_DEMON_GOD)
	aux.AddEra(c,ERA_DARK_DEMON_REALM_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--dark over realm
	aux.EnableDarkOverRealm(c,3)
	--search (to hand)
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
scard.combo_cost=0
--search (to hand)
function scard.thfilter(c)
	return c:IsCharacter(CHARACTER_DEMIGRA) and c:IsEnergyBelow(4) and c:IsAbleToHand()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.thfilter,LOCATION_DECK,0,0,1,HINTMSG_ATOHAND)
scard.op1=aux.TargetSendtoHandOperation(true)
