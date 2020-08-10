--BT3-074 Android 15, Just Saying Hi
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_ANDROID_15)
	aux.AddSpecialTrait(c,TRAIT_ANDROID)
	aux.AddEra(c,ERA_ANDROID_13_SAGA)
	aux.AddCategory(c,NAME_CATEGORY_ANDROID)
	--battle card
	aux.EnableBattleAttribute(c)
	--drop
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--drop
scard.tg1=aux.TargetCardFunction(PLAYER_OPPO,aux.HandFilter(Card.IsAbleToDrop),0,LOCATION_HAND,1,1,HINTMSG_DROP)
scard.op1=aux.TargetCardsOperation(Duel.SendtoDrop,REASON_EFFECT)
