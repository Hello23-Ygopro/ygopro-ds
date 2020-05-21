--BT2-106 Awakening Core Meta-Cooler
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_META_COOLER)
	aux.AddSpecialTrait(c,TRAIT_FRIEZA_CLAN)
	aux.AddEra(c,ERA_META_COOLER_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--evolve
	aux.EnableEvolve(c,aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_META_COOLER),aux.PaySkillCost(COLOR_YELLOW,2,2))
	--ignore awaken condition
	aux.AddPermanentSkill(c,EFFECT_IGNORE_AWAKEN_CONDITION,scard.con1,LOCATION_LEADER,0,scard.tg1)
	--gain skill
	aux.EnableDoubleStrike(c,nil,LOCATION_BATTLE,0,scard.tg2)
end
scard.specified_cost={COLOR_YELLOW,2}
scard.combo_cost=1
--ignore awaken condition
scard.con1=aux.LifeEqualBelowCondition(PLAYER_OPPO,4)
function scard.tg1(e,c)
	return c:IsLeader() and c:IsCharacter(CHARACTER_META_COOLER)
end
--gain skill
function scard.tg2(e,c)
	return c:IsBattle() and c:IsCharacter(CHARACTER_META_COOLER)
end
