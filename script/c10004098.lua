--BT4-088 Ox-King, Dad at Heart
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_OX_KING)
	aux.AddSpecialTrait(c,TRAIT_EARTHLING,TRAIT_GOKUS_LINEAGE)
	aux.AddEra(c,ERA_BATTLE_OF_GODS_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--gain skill (barrier)
	aux.EnableBarrier(c,nil,LOCATION_BATTLE,0,scard.tg1)
end
scard.specified_cost={COLOR_YELLOW,1}
scard.combo_cost=0
--gain skill (barrier)
function scard.tg1(e,c)
	return c~=e:GetHandler() and c:IsBattle() and c:IsColor(COLOR_YELLOW) and c:IsEnergyBelow(3)
end
