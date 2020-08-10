--BT1-011 Lightning-fast Hit
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_RED,2)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_HIT)
	aux.AddSpecialTrait(c,TRAIT_ALIEN)
	aux.AddEra(c,ERA_CHAMPA_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--evolve
	aux.EnableEvolve(c,aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_HIT),aux.PaySkillCost(COLOR_RED,3,2))
	--double strike
	aux.EnableDoubleStrike(c)
	--damage
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,nil,aux.DuelOperation(Duel.Damage,PLAYER_OPPO,2,REASON_EFFECT),nil,aux.EvolvePlayCondition)
end
