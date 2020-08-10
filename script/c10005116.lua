--BT5-098 Ginyu
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_GINYU)
	aux.AddSpecialTrait(c,TRAIT_GINYU_FORCE,TRAIT_FRIEZAS_ARMY)
	aux.AddEra(c,ERA_RESURRECTION_F_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
end
scard.card_code=CARD_GINYU
