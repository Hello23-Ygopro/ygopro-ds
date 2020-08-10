--EX03-17 Limitless Energy Android 17
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_ANDROID_17)
	aux.AddSpecialTrait(c,TRAIT_ANDROID,TRAIT_UNIVERSE_7)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,NAME_CATEGORY_ANDROID,TRAIT_CATEGORY_UNIVERSE)
	--battle card
	aux.EnableBattleAttribute(c)
	--barrier
	aux.EnableBarrier(c)
	--blocker
	aux.EnableBlocker(c)
	--ko
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
--ko
scard.con1=aux.SelfLeaderCondition(Card.IsColor,COLOR_GREEN)
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(nil),0,LOCATION_BATTLE,0,1,HINTMSG_KO)
scard.op1=aux.TargetCardsOperation(Duel.KO,REASON_EFFECT)
