--P-033 Endless Evolution Broly
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_BROLY)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_BROLY_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--reduce skill cost
	aux.AddPermanentUpdateSkillCost(c,-2,COLOR_GREEN,LOCATION_HAND,0,scard.tg1,aux.SelfEvolvingCondition)
	--ko
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg2,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
scard.specified_cost={COLOR_GREEN,2}
scard.combo_cost=0
--reduce skill cost
function scard.tg1(e,c)
	return c:IsCharacter(CHARACTER_BROLY) and c:IsHasEffect(EFFECT_EVOLVE)
end
--ko
scard.tg2=aux.TargetCardFunction(PLAYER_OPPO,aux.BattleAreaFilter(nil),0,LOCATION_BATTLE,1,1,HINTMSG_KO)
scard.op1=aux.TargetCardsOperation(Duel.KO,REASON_EFFECT)
