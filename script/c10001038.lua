--BT1-031_SPR God Break Son Goku (Alias)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,3)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_SON_GOKU)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_RESURRECTION_F_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOKU)
	--battle card
	aux.EnableBattleAttribute(c)
	--evolve
	aux.EnableEvolve(c,aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_SON_GOKU),aux.PaySkillCost(COLOR_BLUE,3,3))
	--double strike
	aux.EnableDoubleStrike(c)
	--cannot activate
	aux.AddPermanentPlayerCannotActivate(c,aux.CannotActivateKeySkillValue(CATEGORY_COUNTER+CATEGORY_BLOCKER),aux.SelfAttackerCondition,0,1)
end
