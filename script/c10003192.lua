--TB1-036 Brothers of Terror Bergamo
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,3)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_BERGAMO)
	aux.AddSpecialTrait(c,TRAIT_ALIEN,TRAIT_TRIO_DE_DANGERS,TRAIT_UNIVERSE_9)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,TRAIT_CATEGORY_UNIVERSE)
	--battle card
	aux.EnableBattleAttribute(c)
	--double strike
	aux.EnableDoubleStrike(c)
	--cannot charge
	aux.AddPermanentSkill(c,EFFECT_CANNOT_TO_ENERGY,scard.con1,0,LOCATION_ALL)
end
--cannot charge
function scard.con1(e)
	local tp=e:GetHandlerPlayer()
	return Duel.IsExistingMatchingCard(aux.BattleAreaFilter(Card.IsCharacter,CHARACTER_LAVENDER),tp,LOCATION_BATTLE,0,1,nil)
		and Duel.IsExistingMatchingCard(aux.BattleAreaFilter(Card.IsCharacter,CHARACTER_BASIL),tp,LOCATION_BATTLE,0,1,nil)
end
