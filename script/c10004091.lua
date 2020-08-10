--BT4-081 Dynasty Deferred Son Goku
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_SON_GOKU_GT)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_GOKUS_LINEAGE)
	aux.AddEra(c,ERA_BABY_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_GT,CHAR_CATEGORY_SON_GOKU)
	--battle card
	aux.EnableBattleAttribute(c)
	--swap
	aux.EnableSwap(c,5,aux.FilterBoolFunction(Card.IsSpecialTrait,TRAIT_GOKUS_LINEAGE),aux.PaySkillCost(COLOR_YELLOW,3,0))
	--barrier
	aux.EnableBarrier(c)
	--untap
	aux.AddAutoSkill(c,0,EVENT_PHASE+PHASE_END,nil,aux.SelfSwitchtoActiveOperation,nil,aux.AND(aux.TurnPlayerCondition(PLAYER_SELF),aux.SelfRestCondition))
end
