--TB1-057 Girl Warrior Brianne De Chateau
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_BRIANNE_DE_CHATEAU)
	aux.AddSpecialTrait(c,TRAIT_ALIEN,TRAIT_MAIDEN_SQUADRON,TRAIT_UNIVERSE_2)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,TRAIT_CATEGORY_UNIVERSE)
	--battle card
	aux.EnableBattleAttribute(c)
	--barrier
	aux.EnableBarrier(c)
	--to hand
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--to hand
function scard.thfilter(c)
	return c:IsSpecialTrait(TRAIT_MAIDEN_SQUADRON) and c:IsAbleToHand()
end
scard.tg1=aux.TargetDecktopTarget(scard.thfilter,7,0,1,HINTMSG_ATOHAND)
scard.op1=aux.TargetDecktopSendtoHandOperation(7,SEQ_DECK_SHUFFLE,true)
