--BT4-094 Jiren, Universe's Strongest
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_JIREN)
	aux.AddSpecialTrait(c,TRAIT_ALIEN,TRAIT_PRIDE_TROOPERS,TRAIT_UNIVERSE_11)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,TRAIT_CATEGORY_UNIVERSE)
	--battle card
	aux.EnableBattleAttribute(c)
	--deflect
	aux.EnableDeflect(c)
	--quadruple strike
	aux.EnableQuadStrike(c)
	--reduce energy cost
	aux.AddPermanentUpdateEnergyCost(c,-6,nil,aux.ExistingCardCondition(aux.DropAreaFilter(Card.IsSpecialTrait,TRAIT_UNIVERSE_11),LOCATION_DROP,0,9))
	--cannot activate
	aux.AddPermanentPlayerCannotActivate(c,aux.CannotActivateKeySkillValue(CATEGORY_COUNTER+CATEGORY_BLOCKER),aux.SelfAttackerCondition,0,1)
end
scard.specified_cost={COLOR_YELLOW,6}
scard.combo_cost=1
