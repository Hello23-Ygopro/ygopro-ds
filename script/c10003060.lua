--BT3-055 Going All In, SSB Vegito
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_VEGITO)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_FUTURE_TRUNKS_SAGA)
	--leader card
	aux.EnableLeaderAttribute(c)
	--gain power
	aux.AddPermanentUpdatePower(c,5000,scard.con1)
	--double strike
	aux.EnableDoubleStrike(c,scard.con1)
	--draw, gain skill
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.op1)
end
scard.front_side_code=sid-1
--gain power, double strike
function scard.con1(e)
	local tp=e:GetHandlerPlayer()
	return Duel.GetTurnPlayer()==tp and Duel.GetMatchingGroupCount(aux.BattleAreaFilter(nil),tp,0,LOCATION_BATTLE,nil)==0
end
--draw, gain skill
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	if Duel.GetMatchingGroupCount(aux.BattleAreaFilter(nil),tp,0,LOCATION_BATTLE,nil)>2 then return end
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	Duel.BreakEffect()
	--gain power
	aux.AddTempSkillUpdatePower(c,c,1,5000)
end
