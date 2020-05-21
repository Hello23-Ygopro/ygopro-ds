--BT2-111 Secret Evolution Cooler
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_COOLER)
	aux.AddSpecialTrait(c,TRAIT_FRIEZA_CLAN)
	aux.AddEra(c,ERA_COOLER_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--gain skill (evolve)
	aux.AddGrantPermanentSkillEvolve(c,scard.evofilter,aux.PaySkillCost(COLOR_YELLOW,3,0),LOCATION_HAND,0,scard.tg1,scard.con1)
end
scard.specified_cost={COLOR_YELLOW,2}
scard.combo_cost=0
--gain skill (evolve)
scard.evofilter=aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_COOLER)
scard.tg1=aux.TargetBoolFunction(Card.IsCharacter,CHARACTER_COOLER)
scard.con1=aux.ExistingCardCondition(aux.DropAreaFilter(Card.IsSpecialTrait,TRAIT_COOLERS_ARMORED_SQUADRON),LOCATION_DROP,0,3)
