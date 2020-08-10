--TB2-026 Awkward Situation Trunks
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_TRUNKS_ADOLESCENCE)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_EARTHLING,TRAIT_WORLD_TOURNAMENT)
	aux.AddEra(c,ERA_MAJIN_BUU_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--ko
	local e1=aux.AddActivateMainSkill(c,0,scard.op1,scard.cost1,scard.tg1,EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
end
--ko
scard.cost1=aux.SendtoDeckCost(aux.BattleAreaFilter(Card.IsCode,CARD_AWKWARD_SITUATION_OTOKOSUKI),LOCATION_BATTLE,0,1,1,SEQ_DECK_BOTTOM)
scard.con1=aux.SelfLeaderCondition(Card.IsSpecialTrait,TRAIT_WORLD_TOURNAMENT)
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(nil),0,LOCATION_BATTLE,0,1,HINTMSG_KO,scard.con1)
scard.op1=aux.TargetCardsOperation(Duel.KO,REASON_EFFECT)
