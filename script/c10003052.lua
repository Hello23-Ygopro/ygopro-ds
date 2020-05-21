--BT3-048 Out of Control Evil, Majin Buu
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_MAJIN_BUU)
	aux.AddSpecialTrait(c,TRAIT_MAJIN)
	aux.AddEra(c,ERA_MAJIN_BUU_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--union-absorb
	aux.EnableUnionAbsorb(c,scard.uniafilter,scard.cost1)
	--critical
	aux.EnableCritical(c)
end
scard.specified_cost={COLOR_BLUE,2}
scard.combo_cost=0
--union-absorb
function scard.uniafilter(c)
	return c:IsColor(COLOR_BLUE) and c:IsCharacter(CHARACTER_MAJIN_BUU) and c:IsEnergy(5)
end
scard.cost1=aux.MergeCost(aux.PaySkillCost(COLOR_BLUE,1,0),aux.AbsorbCost(aux.HandFilter(Card.IsBattle),LOCATION_HAND,0,0,1))
