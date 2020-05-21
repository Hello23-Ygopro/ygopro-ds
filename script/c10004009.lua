--BT4-007 Extra Strike SS Son Goten
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_SON_GOTEN_GT)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_BABY_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_GT)
	--battle card
	aux.EnableBattleAttribute(c)
	--evolve
	aux.EnableEvolve(c,aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_SON_GOTEN_GT),aux.PaySkillCost(COLOR_RED,2,0))
	--dual attack
	aux.EnableDualAttack(c)
	--gain power
	aux.AddPermanentUpdatePower(c,5000,aux.HandEqualBelowCondition(PLAYER_SELF,4))
	--attack active
	aux.AddSinglePermanentSkill(c,EFFECT_ATTACK_ACTIVE_MODE,aux.HandEqualBelowCondition(PLAYER_SELF,4))
end
scard.specified_cost={COLOR_RED,2}
scard.combo_cost=0
