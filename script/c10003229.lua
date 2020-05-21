--TB1-070 Dercori
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_DERCORI)
	aux.AddSpecialTrait(c,TRAIT_ALIEN,TRAIT_UNIVERSE_4)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,TRAIT_CATEGORY_UNIVERSE)
	--battle card
	aux.EnableBattleAttribute(c)
end
scard.specified_cost={COLOR_GREEN,1}
scard.combo_cost=0
