--TB1-032 Focused Mind Piccolo
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_PICCOLO)
	aux.AddSpecialTrait(c,TRAIT_NAMEKIAN,TRAIT_GOD,TRAIT_UNIVERSE_7)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,TRAIT_CATEGORY_UNIVERSE)
	--battle card
	aux.EnableBattleAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--barrier
	aux.EnableBarrier(c)
	--gain power
	aux.AddPermanentUpdatePower(c,5000,aux.AND(aux.TurnPlayerCondition(PLAYER_OPPO),aux.EnergyEqualAboveCondition(PLAYER_SELF,4)))
end
scard.specified_cost={COLOR_BLUE,2}
scard.combo_cost=0
