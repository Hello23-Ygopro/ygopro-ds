--BT4-080 Deadly Golden Great Ape Son Goku
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,2)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_SON_GOKU_GT)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_GREAT_APE,TRAIT_GOKUS_LINEAGE)
	aux.AddEra(c,ERA_BABY_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_GT,CHAR_CATEGORY_SON_GOKU)
	--battle card
	aux.EnableBattleAttribute(c)
	--swap
	aux.EnableSwap(c,5,aux.FilterBoolFunction(Card.IsSpecialTrait,TRAIT_GOKUS_LINEAGE),aux.PaySkillCost(COLOR_YELLOW,1,0))
	--cannot play
	aux.AddSinglePermanentSkill(c,EFFECT_PLAY_CONDITION,aux.NOT(aux.SelfLeaderCondition(Card.IsCharacter,CHARACTER_SON_GOKU_GT)))
	--search (to hand)
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--search (to hand)
function scard.thfilter(c)
	return c:IsSpecialTrait(TRAIT_GOKUS_LINEAGE) and c:IsEnergyBelow(5) and not c:IsCode(sid) and c:IsAbleToHand()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.thfilter,LOCATION_DECK,0,0,1,HINTMSG_ATOHAND)
scard.op1=aux.TargetSendtoHandOperation(true)
