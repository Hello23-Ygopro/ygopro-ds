--BT4-064 Dark Vassal Tambourine
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_TAMBOURINE)
	aux.AddSpecialTrait(c,TRAIT_DEMON_CLAN)
	aux.AddEra(c,ERA_KING_PICCOLO_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--critical
	aux.EnableCritical(c)
end
