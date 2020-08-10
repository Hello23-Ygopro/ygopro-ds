--EX01-05 Unified Spirit Son Goten
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_SON_GOTEN)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_MAJIN_BUU_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--return
	aux.AddActivateMainSkill(c,0,aux.SelfSendtoHandOperation,nil,aux.SelfSendtoHandTarget)
	--to hand
	aux.AddSingleAutoSkill(c,1,EVENT_ATTACK_ANNOUNCE,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--to hand
function scard.thfilter(c)
	return c:IsCharacter(CHARACTER_TRUNKS_YOUTH) and c:IsPowerBelow(15000) and c:IsAbleToHand()
end
scard.tg1=aux.TargetDecktopTarget(scard.thfilter,7,0,1,HINTMSG_ATOHAND)
scard.op1=aux.TargetDecktopSendtoHandOperation(7,SEQ_DECK_SHUFFLE,true)
