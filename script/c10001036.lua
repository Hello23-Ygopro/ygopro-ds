--BT1-030 Super Saiyan Blue Son Goku
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_SON_GOKU)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_RESURRECTION_F_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOKU)
	--leader card
	aux.EnableLeaderAttribute(c)
	--dual attack
	aux.EnableDualAttack(c,aux.EnergyEqualAboveCondition(PLAYER_SELF,7))
	--draw, gain skill
	local e1=aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.op1)
	e1:SetCountLimit(1)
end
scard.front_side_code=sid-1
--draw, gain skill
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	Duel.BreakEffect()
	--gain power
	aux.AddTempSkillUpdatePower(c,c,1,scard.val1)
end
function scard.val1(e,c)
	return Duel.GetEnergyCount(c:GetControler())*1000
end
