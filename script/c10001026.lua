--BT1-023 Kai Attendant of Universe 6
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_RED,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_SUPREME_KAIS_ATTENDANT)
	aux.AddSpecialTrait(c,TRAIT_GOD)
	aux.AddEra(c,ERA_CHAMPA_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--attack limit
	aux.AddPermanentCannotSelectBattleTarget(c,scard.val1)
end
--attack limit
function scard.val1(e,c)
	return c:IsBattle() and c:IsPowerAbove(15000)
end
