--BT5-060 Spirited Search SS Trunks
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_TRUNKS_GT)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_SUPER_17_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_GT)
	--battle card
	aux.EnableBattleAttribute(c)
	--to hand
	local e1=aux.AddActivateMainSkill(c,0,scard.op1,nil,scard.tg1,EFFECT_FLAG_CARD_TARGET,aux.LifeEqualBelowCondition(PLAYER_SELF,4))
	e1:SetCountLimit(1)
	--search (drop)
	aux.AddSingleAutoSkill(c,1,EVENT_PLAY,scard.tg2,scard.op2,EFFECT_FLAG_CARD_TARGET,aux.LifeEqualAboveCondition(PLAYER_SELF,5))
end
--to hand
function scard.thfilter(c)
	return c:IsColor(COLOR_GREEN+COLOR_BLACK) and c:IsSpecialTrait(TRAIT_DESIRE) and c:IsAbleToHand()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.DropAreaFilter(scard.thfilter),LOCATION_DROP,0,1,1,HINTMSG_ATOHAND)
scard.op1=aux.TargetSendtoHandOperation(true)
--search (drop)
function scard.dropfilter(c)
	return c:IsHasEffect(EFFECT_DRAGON_BALL) and c:IsAbleToDrop()
end
scard.tg2=aux.TargetCardFunction(PLAYER_SELF,scard.dropfilter,LOCATION_DECK,0,0,2,HINTMSG_DROP)
scard.op2=aux.TargetCardsOperation(Duel.SendtoDrop,REASON_EFFECT)
