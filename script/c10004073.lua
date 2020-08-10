--BT4-066 Dark Vassal Drum
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_DRUM)
	aux.AddSpecialTrait(c,TRAIT_DEMON_CLAN)
	aux.AddEra(c,ERA_KING_PICCOLO_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
end
