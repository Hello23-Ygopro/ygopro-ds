--SD1-05 Vegeta, Prince of Speed
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_VEGETA)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_BATTLE_OF_GODS_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--evolve
	aux.EnableEvolve(c,aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_VEGETA),aux.PaySkillCost(COLOR_BLUE,2,2))
	--double strike
	aux.EnableDoubleStrike(c)
	--draw
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,nil,aux.DuelOperation(Duel.Draw,PLAYER_SELF,2,REASON_EFFECT),nil,aux.EnergyEqualAboveCondition(PLAYER_SELF,5))
end
scard.specified_cost={COLOR_BLUE,3}
scard.combo_cost=1
