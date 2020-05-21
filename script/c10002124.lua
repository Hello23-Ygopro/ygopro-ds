--BT2-109 Meta-Cooler Core
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_META_COOLER_CORE)
	aux.AddSpecialTrait(c,TRAIT_FRIEZA_CLAN)
	aux.AddEra(c,ERA_META_COOLER_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--union-absorb
	aux.EnableUnionAbsorb(c,aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_META_COOLER_CORE),scard.cost1)
end
scard.specified_cost={COLOR_YELLOW,1}
scard.combo_cost=0
--union-absorb
scard.cost1=aux.MergeCost(aux.PaySkillCost(COLOR_YELLOW,2,3),aux.AbsorbCost(aux.FaceupFilter(Card.IsCode,CARD_BIG_GETE_STAR),LOCATION_BATTLE,0,1))
