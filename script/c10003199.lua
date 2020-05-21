--TB1-043 Universe 9 Striker Hyssop
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_HYSSOP)
	aux.AddSpecialTrait(c,TRAIT_ALIEN,TRAIT_UNIVERSE_9)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,TRAIT_CATEGORY_UNIVERSE)
	--battle card
	aux.EnableBattleAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--free play
	aux.AddPermanentFreePlay(c,aux.ExistingCardCondition(aux.BattleAreaFilter(Card.IsSpecialTrait,TRAIT_UNIVERSE_9),LOCATION_BATTLE))
end
scard.specified_cost={COLOR_BLUE,2}
scard.combo_cost=0
