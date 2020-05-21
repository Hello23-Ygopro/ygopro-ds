--TB2-050 Jackie Chun, the Mysterious Fighter
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_JACKIE_CHUN)
	aux.AddSpecialTrait(c,TRAIT_EARTHLING,TRAIT_WORLD_TOURNAMENT)
	aux.AddEra(c,ERA_WORLD_MA_TOURNAMENT_SAGA)
	--leader card
	aux.EnableLeaderAttribute(c)
	--draw, gain skill
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.op1)
	--cannot combo
	aux.AddPermanentPlayerSkill(c,EFFECT_CANNOT_COMBO,LOCATION_LEADER,scard.con1,0,1)
end
scard.front_side_code=sid-1
--draw, gain skill
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	--gain power
	aux.AddTempSkillUpdatePower(c,c,1,5000)
end
--cannot combo
function scard.con1(e)
	local tc=Duel.GetAttackTarget()
	return Duel.GetAttacker()==e:GetHandler() and tc:IsBattle() and tc:IsRest()
end
