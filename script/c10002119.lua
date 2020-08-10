--BT2-105 Overpowering King Cold
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,4)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_KING_COLD)
	aux.AddSpecialTrait(c,TRAIT_FRIEZA_CLAN)
	aux.AddEra(c,ERA_ANDROID_CELL_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--reduce energy cost
	aux.AddPermanentUpdateEnergyCost(c,-2,nil,nil,LOCATION_BATTLE,LOCATION_HAND+LOCATION_BATTLE,LOCATION_HAND+LOCATION_BATTLE,scard.tg1)
end
--reduce energy cost
function scard.tg1(e,c)
	return c:IsSpecialTrait(TRAIT_FRIEZA_CLAN) and c:GetOriginalEnergy()>=5
end
