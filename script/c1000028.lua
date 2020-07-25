--P-026 Awakened Strike SSB Son Goku
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_SON_GOKU)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_FUTURE_TRUNKS_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOKU)
	--leader card
	aux.EnableLeaderAttribute(c)
	--gain skill
	local e1=aux.AddActivateMainSkill(c,0,scard.op1,scard.cost1,nil,EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
	--draw
	aux.AddSingleAutoSkill(c,1,EVENT_ATTACK_ANNOUNCE,nil,aux.DuelOperation(Duel.Draw,PLAYER_SELF,1,REASON_EFFECT))
end
scard.front_side_code=sid-1
--gain skill
scard.cost1=aux.SendtoHandCost(aux.LifeAreaFilter(nil),LOCATION_LIFE,0,1)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	--double strike
	aux.AddTempSkillCustom(c,c,2,EFFECT_DOUBLE_STRIKE)
	if Duel.GetEnergyCount(tp)>=7 then
		--gain power
		aux.AddTempSkillUpdatePower(c,c,3,5000)
	end
end
