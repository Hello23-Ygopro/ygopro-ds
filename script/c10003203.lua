--TB1-047 Murichim
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_MURICHIM)
	aux.AddSpecialTrait(c,TRAIT_ALIEN,TRAIT_UNIVERSE_10)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,TRAIT_CATEGORY_UNIVERSE)
	--battle card
	aux.EnableBattleAttribute(c)
end
scard.specified_cost={COLOR_BLUE,1}
scard.combo_cost=0
