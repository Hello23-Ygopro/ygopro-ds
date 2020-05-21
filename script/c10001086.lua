--BT1-075 Rampaging Super Saiyan Broly
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_BROLY)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_BROLY_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--triple strike
	aux.EnableTripleStrike(c)
end
scard.specified_cost={COLOR_GREEN,2}
scard.combo_cost=1
