--BT2-007 Fully Trained Son Gohan
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_SON_GOHAN_ADOLESCENCE)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_MAJIN_BUU_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOHAN)
	--battle card
	aux.EnableBattleAttribute(c)
	--gain skill (evolve)
	aux.AddGrantPermanentSkillEvolve(c,scard.evofilter,aux.PaySkillCost(COLOR_RED,2,1),LOCATION_HAND,0,scard.tg1)
end
scard.specified_cost={COLOR_RED,1}
scard.combo_cost=0
--gain skill (evolve)
scard.evofilter=aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_SON_GOHAN_ADOLESCENCE)
scard.tg1=aux.TargetBoolFunction(Card.IsCharacter,CHARACTER_SON_GOHAN_ADOLESCENCE)
