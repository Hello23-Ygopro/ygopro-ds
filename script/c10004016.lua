--BT4-014 Saiyan Daughter Bulla
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_BULLA)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_BABY_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--to hand
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
scard.specified_cost={COLOR_RED,1}
scard.combo_cost=0
--to hand
function scard.thfilter(c)
	return c:IsBattle() and c:IsColor(COLOR_RED)
		and c:IsCharacter(CHARACTER_VEGETA_GT,CHARACTER_TRUNKS_GT,CHARACTER_BULMA_GT) and c:IsAbleToHand()
end
scard.tg1=aux.TargetDecktopTarget(scard.thfilter,7,0,1,HINTMSG_ATOHAND)
scard.op1=aux.TargetDecktopSendtoHandOperation(7,SEQ_DECK_SHUFFLE,true)
