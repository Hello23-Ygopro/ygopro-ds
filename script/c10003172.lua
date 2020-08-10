--TB1-019 Frost, The Tactician
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_RED,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_FROST)
	aux.AddSpecialTrait(c,TRAIT_FRIEZA_CLAN,TRAIT_ALIEN,TRAIT_UNIVERSE_6)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,TRAIT_CATEGORY_UNIVERSE)
	--battle card
	aux.EnableBattleAttribute(c)
	--search (to hand)
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--search (to hand)
function scard.thfilter(c)
	return c:IsCharacter(CHARACTER_FROST) and c:IsPowerBelow(20000) and c:IsAbleToHand()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.thfilter,LOCATION_DECK,0,0,1,HINTMSG_ATOHAND)
scard.op1=aux.TargetSendtoHandOperation(true)
