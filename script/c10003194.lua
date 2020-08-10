--TB1-038 Trio De Dangers Basil
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_BASIL)
	aux.AddSpecialTrait(c,TRAIT_ALIEN,TRAIT_TRIO_DE_DANGERS,TRAIT_UNIVERSE_9)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,TRAIT_CATEGORY_UNIVERSE)
	--battle card
	aux.EnableBattleAttribute(c)
	--gain power
	aux.AddPermanentUpdatePower(c,scard.val1,scard.con1)
	--dual attack
	aux.EnableDualAttack(c,scard.con1)
end
--gain power, dual attack
function scard.con1(e)
	local tp=e:GetHandlerPlayer()
	return Duel.GetTurnPlayer()==tp
		and Duel.IsExistingMatchingCard(aux.BattleAreaFilter(Card.IsSpecialTrait,TRAIT_TRIO_DE_DANGERS),tp,LOCATION_BATTLE,0,1,e:GetHandler())
end
function scard.val1(e,c)
	return Duel.GetEnergyCount(c:GetControler())*1000
end
