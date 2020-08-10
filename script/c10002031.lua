--BT2-028 Majin Buu Revived
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_RED,4)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_MAJIN_BUU)
	aux.AddSpecialTrait(c,TRAIT_MAJIN)
	aux.AddEra(c,ERA_MAJIN_BUU_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--double strike
	aux.EnableDoubleStrike(c)
	--damage
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,nil,aux.DuelOperation(Duel.Damage,PLAYER_OPPO,1,REASON_EFFECT),nil,aux.SealedBallPlayCondition)
end
