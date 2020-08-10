--BT4-065 Dark Vassal Cymbal
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_CYMBAL)
	aux.AddSpecialTrait(c,TRAIT_DEMON_CLAN)
	aux.AddEra(c,ERA_KING_PICCOLO_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--blocker
	aux.EnableBlocker(c)
end
