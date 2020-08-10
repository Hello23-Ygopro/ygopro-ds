--TB1-041 Universe 9 Striker Hop
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_HOP)
	aux.AddSpecialTrait(c,TRAIT_ALIEN,TRAIT_UNIVERSE_9)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,TRAIT_CATEGORY_UNIVERSE)
	--battle card
	aux.EnableBattleAttribute(c)
	--critical
	aux.EnableCritical(c)
	--cannot activate
	aux.AddPermanentPlayerCannotActivate(c,aux.CannotActivateKeySkillValue(CATEGORY_BLOCKER),scard.con1,0,1)
end
--cannot activate
function scard.con1(e)
	local c=e:GetHandler()
	return Duel.GetAttacker()==c
		and Duel.IsExistingMatchingCard(aux.BattleAreaFilter(Card.IsSpecialTrait,TRAIT_UNIVERSE_9),e:GetHandlerPlayer(),LOCATION_BATTLE,0,1,c)
end
