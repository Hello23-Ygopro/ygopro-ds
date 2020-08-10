--TB2-066 Announcer, Ever-Curious
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_ANNOUNCER)
	aux.AddSpecialTrait(c,TRAIT_EARTHLING,TRAIT_WORLD_TOURNAMENT)
	aux.AddEra(c,ERA_WORLD_MA_TOURNAMENT_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--to hand
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
--to hand
scard.con1=aux.SelfLeaderCondition(Card.IsSpecialTrait,TRAIT_WORLD_TOURNAMENT)
function scard.thfilter(c)
	return c:IsSpecialTrait(TRAIT_WORLD_TOURNAMENT) and c:IsAbleToHand()
end
scard.tg1=aux.TargetDecktopTarget(scard.thfilter,7,0,1,HINTMSG_ATOHAND)
scard.op1=aux.TargetDecktopSendtoHandOperation(7,SEQ_DECK_SHUFFLE,true)
