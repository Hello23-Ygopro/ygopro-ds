--BT1-011_SPR Lightning-fast Hit (Alias)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
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
scard.specified_cost={COLOR_RED,2}
scard.combo_cost=1
