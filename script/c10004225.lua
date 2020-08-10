--TB2-028 Scuffle Time Mr. Buu
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_MR_BUU)
	aux.AddSpecialTrait(c,TRAIT_MAJIN,TRAIT_WORLD_TOURNAMENT)
	aux.AddEra(c,ERA_MAJIN_BUU_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--barrier
	aux.EnableBarrier(c)
	--return
	aux.AddActivateMainSkill(c,0,scard.op1,aux.SelfSendtoDeckCost(SEQ_DECK_BOTTOM),scard.tg1,EFFECT_FLAG_CARD_TARGET)
end
--return
scard.con1=aux.ExistingCardCondition(aux.BattleAreaFilter(Card.IsCode,CARD_SCUFFLE_TIME_SON_GOTEN),LOCATION_BATTLE)
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(Card.IsAbleToHand),0,LOCATION_BATTLE,0,1,HINTMSG_RTOHAND,scard.con1)
scard.op1=aux.TargetSendtoHandOperation(nil)
