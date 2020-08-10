--TB1-080 Ally of Justice Toppo
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,3)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_TOPPO)
	aux.AddSpecialTrait(c,TRAIT_ALIEN,TRAIT_PRIDE_TROOPERS,TRAIT_UNIVERSE_11)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,TRAIT_CATEGORY_UNIVERSE)
	--battle card
	aux.EnableBattleAttribute(c)
	--play
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,nil,aux.SelfLeaderCondition(Card.IsSpecialTrait,TRAIT_UNIVERSE_11))
end
--play
function scard.playfilter(c,e,tp)
	return c:IsSpecialTrait(TRAIT_UNIVERSE_11) and c:IsEnergyBelow(3) and c:IsCanBePlayed(e,0,tp,false,false)
end
scard.tg1=aux.TargetDecktopTarget(scard.playfilter,10,0,2,HINTMSG_PLAY)
scard.op1=aux.TargetDecktopPlayOperation(10,SEQ_DECK_SHUFFLE,POS_FACEUP_REST)
