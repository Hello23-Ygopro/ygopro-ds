--BT4-020 Vow Revenge
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--extra card
	aux.EnableExtraAttribute(c)
	--gain skill
	aux.AddActivateMainSkill(c,0,scard.op1,nil,scard.tg1,EFFECT_FLAG_CARD_TARGET,aux.SelfLeaderCondition(scard.lfilter))
end
--gain skill
function scard.lfilter(c)
	return c:IsColor(COLOR_RED) and c:IsSpecialTrait(TRAIT_MACHINE_MUTANT)
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(nil),0,LOCATION_BATTLE,0,1,HINTMSG_TARGET)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) or not tc:IsFaceup() then return end
	--lose power
	aux.AddTempSkillUpdatePower(e:GetHandler(),tc,1,-15000)
end
