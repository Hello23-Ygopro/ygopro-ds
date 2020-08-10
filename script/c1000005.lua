--P-005 Light of Hope Trunks
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_TRUNKS_FUTURE)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_FUTURE_TRUNKS_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--gain power
	aux.AddPermanentUpdatePower(c,5000,scard.con1,LOCATION_BATTLE,0,scard.tg1)
end
--gain power
scard.con1=aux.AND(aux.TurnPlayerCondition(PLAYER_SELF),aux.EnergyEqualAboveCondition(PLAYER_SELF,5))
function scard.tg1(e,c)
	return c:IsLeader() or c==e:GetHandler()
end
