--BT2-036 Goku Black, The Bringer of Despair
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_GOKU_BLACK)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_GOD)
	aux.AddEra(c,ERA_FUTURE_TRUNKS_SAGA)
	--leader card
	aux.EnableLeaderAttribute(c)
	--gain power
	aux.AddPermanentUpdatePower(c,5000,aux.AND(aux.TurnPlayerCondition(PLAYER_SELF),aux.LifeEqualBelowCondition(PLAYER_SELF,2)))
	--double strike
	aux.EnableDoubleStrike(c,aux.AND(aux.TurnPlayerCondition(PLAYER_SELF),aux.LifeEqualBelowCondition(PLAYER_SELF,2)))
	--draw
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,aux.DuelOperation(Duel.Draw,PLAYER_SELF,1,REASON_EFFECT))
end
scard.front_side_code=sid-1
