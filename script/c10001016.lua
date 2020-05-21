--BT1-013 Raging Cabba
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_CABBA)
	aux.AddSpecialTrait(c,TRAIT_ALIEN,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_CHAMPA_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--evolve
	aux.EnableEvolve(c,aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_CABBA),aux.PaySkillCost(COLOR_RED,2,1))
	--double strike
	aux.EnableDoubleStrike(c)
	--untap
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,nil,aux.SelfSwitchtoActiveOperation,nil,aux.EvolvePlayCondition)
end
scard.specified_cost={COLOR_RED,2}
scard.combo_cost=1
