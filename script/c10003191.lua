--TB1-035 Trio De Dangers Bergamo
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
	--attack limit
	aux.AddPermanentCannotSelectBattleTarget(c,scard.val1,aux.SelfRestCondition,0,LOCATION_BATTLE,aux.TargetBoolFunction(Card.IsBattle))
	--gain skill (barrier)
	aux.EnableBarrier(c,scard.con1,LOCATION_BATTLE,0,aux.TargetBoolFunction(Card.IsSpecialTrait,TRAIT_TRIO_DE_DANGERS))
	--gain skill
	aux.AddSingleAutoSkill(c,0,EVENT_BE_BATTLE_TARGET,nil,scard.op1)
end
--attack limit
function scard.val1(e,c)
	return c~=e:GetHandler()
end
--gain skill (barrier)
function scard.con1(e)
	local tp=e:GetHandlerPlayer()
	return Duel.IsExistingMatchingCard(aux.BattleAreaFilter(Card.IsCharacter,CHARACTER_LAVENDER),tp,LOCATION_BATTLE,0,1,nil)
		and Duel.IsExistingMatchingCard(aux.BattleAreaFilter(Card.IsCharacter,CHARACTER_BASIL),tp,LOCATION_BATTLE,0,1,nil)
end
--gain skill
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	--gain power
	aux.AddTempSkillUpdatePower(c,c,1,5000)
end
