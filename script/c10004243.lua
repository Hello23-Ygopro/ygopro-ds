--TB2-043 Tien Shinhan, Trading Moves
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_TIEN_SHINHAN)
	aux.AddSpecialTrait(c,TRAIT_EARTHLING,TRAIT_WORLD_TOURNAMENT)
	aux.AddEra(c,ERA_WORLD_MA_TOURNAMENT_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--barrier
	aux.EnableBarrier(c)
	--untap, gain skill
	local e1=aux.AddActivateMainSkill(c,0,scard.op1,scard.cost1,nil,EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
end
scard.specified_cost={COLOR_GREEN,2}
scard.combo_cost=0
--untap, gain skill
scard.cost1=aux.KOCost(aux.BattleAreaFilter(Card.IsCode,CARD_MERCENARY_TAO_TRADING_MOVES),LOCATION_BATTLE,0,1,1,true)
function scard.lfilter(c)
	return c:IsColor(COLOR_GREEN) and c:IsSpecialTrait(TRAIT_WORLD_TOURNAMENT)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if not aux.SelfLeaderCondition(scard.lfilter)(e,tp,eg,ep,ev,re,r,rp) then return end
	local c=e:GetHandler()
	Duel.SwitchtoActive(c,REASON_EFFECT)
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	--gain power
	aux.AddTempSkillUpdatePower(c,c,1,5000)
	--double strike
	aux.AddTempSkillCustom(c,c,2,EFFECT_DOUBLE_STRIKE)
end
