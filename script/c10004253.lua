--TB2-051 Unyielding Victory Son Goku
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_SON_GOKU_CHILDHOOD)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_WORLD_TOURNAMENT)
	aux.AddEra(c,ERA_WORLD_MA_TOURNAMENT_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOKU)
	--battle card
	aux.EnableBattleAttribute(c)
	--barrier
	aux.EnableBarrier(c)
	--gain skill
	local e1=aux.AddActivateMainSkill(c,0,scard.op1,scard.cost1,nil,EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
end
--gain skill
function scard.lfilter(c)
	return c:IsColor(COLOR_YELLOW) and c:IsSpecialTrait(TRAIT_WORLD_TOURNAMENT)
end
scard.cost1=aux.SwitchtoRestCost(aux.BattleAreaFilter(Card.IsCode,CARD_UNYIELDING_VICTORY_JACKIE_CHUN),LOCATION_BATTLE,0,1)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() or not aux.SelfLeaderCondition(scard.lfilter)(e,tp,eg,ep,ev,re,r,rp) then return end
	--gain power
	aux.AddTempSkillUpdatePower(c,c,1,5000)
	--double strike
	aux.AddTempSkillCustom(c,c,2,EFFECT_DOUBLE_STRIKE)
	--triple attack
	aux.AddTempSkillTripleAttack(c,c,3)
end
