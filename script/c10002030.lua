--BT2-027 Awakening Evil Majin Buu
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_RED,2)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_MAJIN_BUU)
	aux.AddSpecialTrait(c,TRAIT_MAJIN)
	aux.AddEra(c,ERA_MAJIN_BUU_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--evolve
	aux.EnableEvolve(c,scard.evofilter,aux.PaySkillCost(COLOR_RED,2,0))
	--union-absorb
	aux.EnableUnionAbsorb(c,scard.uniafilter,aux.AbsorbCost(aux.HandFilter(Card.IsBattle),LOCATION_HAND,0,0,1))
end
--evolve
function scard.evofilter(c)
	return c:IsColor(COLOR_RED) and c:IsCharacter(CHARACTER_MAJIN_BUU)
end
--union-absorb
function scard.uniafilter(c)
	return c:IsCharacter(CHARACTER_MAJIN_BUU) and not c:IsCode(sid) and c:IsPowerAbove(25000)
end
