--BT4-099 Mira
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_MIRA)
	aux.AddSpecialTrait(c,TRAIT_ANDROID)
	aux.AddEra(c,ERA_DARK_DEMON_REALM_SAGA)
	--leader card
	aux.EnableLeaderAttribute(c)
	--gain skill, drop
	local e1=aux.AddActivateMainSkill(c,0,scard.op1,scard.cost1,nil,EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
	--awaken
	aux.EnableAwaken(c,aux.AwakenLifeCondition(4),0,2)
end
scard.back_side_code=sid+1
--gain skill, drop
scard.cost1=aux.SendtoHandCost(aux.LifeAreaFilter(nil),LOCATION_LIFE,0,1)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	--gain power
	aux.AddTempSkillUpdatePower(c,c,1,5000)
	Duel.BreakEffect()
	Duel.SendDecktoptoDrop(tp,3,REASON_EFFECT)
end
