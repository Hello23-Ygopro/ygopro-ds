--TB2-016 Pui Pui, Magician's Lackey
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_PUI_PUI)
	aux.AddSpecialTrait(c,TRAIT_ALIEN,TRAIT_WORLD_TOURNAMENT)
	aux.AddEra(c,ERA_THE_EVIL_WIZARD_BABIDI_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--critical
	aux.EnableCritical(c)
end
scard.specified_cost={COLOR_RED,2}
scard.combo_cost=0
