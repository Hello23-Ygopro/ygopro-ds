--TB1-065 Maiden Squadron Kakunsa
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_KAKUNSA)
	aux.AddSpecialTrait(c,TRAIT_ALIEN,TRAIT_MAIDEN_SQUADRON,TRAIT_UNIVERSE_2)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,TRAIT_CATEGORY_UNIVERSE)
	--battle card
	aux.EnableBattleAttribute(c)
	--critical
	aux.EnableCritical(c)
	--dual attack
	aux.EnableDualAttack(c,scard.con1)
end
--dual attack
function scard.con1(e)
	local tp=e:GetHandlerPlayer()
	return Duel.IsExistingMatchingCard(aux.BattleAreaFilter(Card.IsCharacter,CHARACTER_RIBRIANNE),tp,LOCATION_BATTLE,0,1,nil)
		and Duel.IsExistingMatchingCard(aux.BattleAreaFilter(Card.IsCharacter,CHARACTER_ROZIE),tp,LOCATION_BATTLE,0,1,nil)
end
