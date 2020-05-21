--BT4-041 Hidden Darkness Minotia
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_MINOTIA)
	aux.AddSpecialTrait(c,TRAIT_HERO)
	aux.AddEra(c,ERA_HIRUDEGARN_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--search (to hand)
	aux.AddSingleAutoSkill(c,0,EVENT_DROP,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
scard.specified_cost={COLOR_BLUE,1}
scard.combo_cost=0
--search (to hand)
scard.con1=aux.AND(aux.SelfPreviousLocationCondition(LOCATION_HAND),aux.SelfLeaderCondition(Card.IsSpecialTrait,TRAIT_PHANTOM_DEMON))
function scard.thfilter(c)
	return c:IsCode(CARD_HIRUDEGARN_THE_WANDERER) and c:IsAbleToHand()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.thfilter,LOCATION_DECK,0,0,1,HINTMSG_ATOHAND)
scard.op1=aux.TargetSendtoHandOperation(true)
