--BT1-059 Awakening Rage Son Goku
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,2)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_SON_GOKU)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_FRIEZA_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOKU)
	--battle card
	aux.EnableBattleAttribute(c)
	--evolve
	aux.EnableEvolve(c,aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_SON_GOKU),aux.PaySkillCost(COLOR_GREEN,3,2))
	--triple strike
	aux.EnableTripleStrike(c,aux.ExistingCardCondition(aux.DropAreaFilter(Card.IsCharacter,CHARACTER_KRILLIN),LOCATION_DROP))
	--ko
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--ko
scard.tg1=aux.TargetTotalCostBelowTarget(PLAYER_SELF,aux.BattleAreaFilter(nil),0,LOCATION_BATTLE,6,HINTMSG_KO)
scard.op1=aux.TargetCardsOperation(Duel.KO,REASON_EFFECT)
