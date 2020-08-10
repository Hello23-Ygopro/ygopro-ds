--BT3-078 Unstoppable Ambition Super Saiyan Caulifla
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_CAULIFLA)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_ALIEN)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--cannot be ko-ed
	aux.AddPermanentCannotBeKOed(c,EFFECT_CANNOT_BE_KOED_EFFECT,aux.indsval,nil,LOCATION_BATTLE,0,aux.TargetBoolFunction(Card.IsBattle))
	--cannot drop
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_DROP)
	e1:SetRange(LOCATION_BATTLE)
	e1:SetTargetRange(LOCATION_BATTLE,0)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsBattle))
	e1:SetValue(aux.indsval)
	c:RegisterEffect(e1)
	--to hand
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--to hand
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.LifeAreaFilter(Card.IsAbleToHand),LOCATION_LIFE,0,1,1,HINTMSG_ATOHAND)
scard.op1=aux.TargetSendtoHandOperation(nil)
