--EX03-20 Indomitable SS Son Goku Jr.
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_SON_GOKU_JR)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_EARTHLING,TRAIT_GOKUS_LINEAGE)
	aux.AddEra(c,ERA_SPECIAL)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOKU)
	--battle card
	aux.EnableBattleAttribute(c)
	--swap
	aux.EnableSwap(c,8,aux.FilterBoolFunction(Card.IsSpecialTrait,TRAIT_GOKUS_LINEAGE),aux.PaySkillCost(COLOR_YELLOW,5,0),scard.con1)
end
--swap
scard.con1=aux.AND(aux.SelfLeaderCondition(Card.IsSpecialTrait,TRAIT_GOKUS_LINEAGE),aux.LifeEqualBelowCondition(PLAYER_SELF,2))
