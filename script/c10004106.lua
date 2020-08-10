--BT4-096 10x Kamehameha
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,1)
	--extra card
	aux.EnableExtraAttribute(c)
	--gain skill
	aux.AddActivateBattleSkill(c,0,scard.op1,nil,nil,nil,aux.SelfLeaderCondition(scard.lfilter))
end
--gain skill
function scard.lfilter(c)
	return c:IsSpecialTrait(TRAIT_GOKUS_LINEAGE) and c:IsCharacterSetCard(CHAR_CATEGORY_SON_GOKU)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetLeaderCard(tp)
	--gain power
	aux.AddTempSkillUpdatePower(c,tc,1,15000,RESET_PHASE+PHASE_DAMAGE)
	--double strike
	aux.AddTempSkillCustom(c,tc,2,EFFECT_DOUBLE_STRIKE,RESET_PHASE+PHASE_DAMAGE)
end
