--TB1-051 Brianne De Chateau
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_BRIANNE_DE_CHATEAU)
	aux.AddSpecialTrait(c,TRAIT_ALIEN,TRAIT_MAIDEN_SQUADRON,TRAIT_UNIVERSE_2)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,TRAIT_CATEGORY_UNIVERSE)
	--leader card
	aux.EnableLeaderAttribute(c)
	--awaken
	aux.EnableAwaken(c)
	--to hand
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,aux.SelfAttackTargetCondition(Card.IsLeader))
end
scard.back_side_code=sid+1
--to hand
function scard.thfilter(c)
	return c:IsSpecialTrait(TRAIT_MAIDEN_SQUADRON) and c:IsAbleToHand()
end
scard.tg1=aux.TargetDecktopTarget(scard.thfilter,2,0,1,HINTMSG_ATOHAND)
scard.op1=aux.TargetDecktopSendtoHandOperation(2,SEQ_DECK_BOTTOM,true)
