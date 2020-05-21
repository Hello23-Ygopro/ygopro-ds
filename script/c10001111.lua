--BT1-096 Ginyu Force Recoome
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_RECOOME)
	aux.AddSpecialTrait(c,TRAIT_GINYU_FORCE,TRAIT_FRIEZAS_ARMY)
	aux.AddEra(c,ERA_FRIEZA_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--gain power
	aux.AddPermanentUpdatePower(c,6000,aux.TurnPlayerCondition(PLAYER_OPPO))
end
scard.specified_cost={COLOR_YELLOW,1}
scard.combo_cost=0
