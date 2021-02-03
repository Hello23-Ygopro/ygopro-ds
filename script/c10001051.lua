--BT1-044 Whis, The Resting Attendant
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,2)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_WHIS)
	aux.AddSpecialTrait(c,TRAIT_GOD)
	aux.AddEra(c,ERA_RESURRECTION_F_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--charge
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,nil,aux.DuelOperation(Duel.SendDecktoEnergy,PLAYER_SELF,1,REASON_EFFECT))
end
