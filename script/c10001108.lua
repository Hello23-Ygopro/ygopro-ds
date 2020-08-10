--BT1-093 Tagoma, The Loyal Warrior
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_TAGOMA)
	aux.AddSpecialTrait(c,TRAIT_FRIEZAS_ARMY)
	aux.AddEra(c,ERA_RESURRECTION_F_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--attack limit
	aux.AddPermanentCannotSelectBattleTarget(c,scard.val1,aux.SelfRestCondition,0,LOCATION_BATTLE)
end
--attack limit
function scard.val1(e,c)
	return c~=e:GetHandler() and c:IsBattle()
end
