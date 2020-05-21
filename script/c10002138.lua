--BT2-123 Ultimate Force SSB Vegito
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_VEGITO)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_FUTURE_TRUNKS_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--union-potara
	aux.EnableUnionPotara(c,scard.unipfilter1,scard.unipfilter2,aux.PaySkillCost(COLOR_RED,5,0))
	--ultimate
	aux.EnableUltimate(c)
	--triple attack
	aux.EnableTripleAttack(c)
	--triple strike
	aux.EnableTripleStrike(c)
end
scard.specified_cost={COLOR_BLUE,3}
scard.combo_cost=1
--union-potara
scard.unipfilter1=aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_SON_GOKU)
scard.unipfilter2=aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_VEGETA)
