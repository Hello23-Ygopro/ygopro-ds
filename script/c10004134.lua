--BT4-121 Dark Kamehameha
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--extra card
	aux.EnableExtraAttribute(c)
	--gain skill, warp
	aux.AddActivateBattleSkill(c,0,scard.op1,nil,nil,EFFECT_FLAG_CARD_TARGET,aux.SelfLeaderCondition(Card.IsCharacter,CHARACTER_MIRA))
end
--gain skill, warp
function scard.warpfilter(c,e)
	return c:IsEnergyBelow(4) and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	--gain power
	aux.AddTempSkillUpdatePower(e:GetHandler(),Duel.GetLeaderCard(tp),1,15000,RESET_PHASE+PHASE_DAMAGE)
	if Duel.GetTurnPlayer()~=tp then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_WARP)
	local g=Duel.SelectMatchingCard(tp,aux.BattleAreaFilter(scard.warpfilter),tp,0,LOCATION_BATTLE,0,1,nil,e)
	if g:GetCount()==0 then return end
	Duel.SetTargetCard(g)
	Duel.SendtoWarp(g,REASON_EFFECT)
end
