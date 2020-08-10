--BT1-066 Tenacious Vegeta
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_VEGETA)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_BATTLE_OF_GODS_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--revenge
	aux.EnableRevenge(c)
	--cannot be attacked
	aux.AddPermanentCannotBeAttacked(c,scard.val1)
end
--cannot be attacked
function scard.val1(e,c)
	return c:IsLeader() and not c:IsImmuneToEffect(e)
end
