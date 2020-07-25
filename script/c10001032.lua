--BT1-028 Super Saiyan Blue Vegeta
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_VEGETA)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_RESURRECTION_F_SAGA)
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
	--critical
	aux.AddTempSkillCritical(c,c,2)
	if Duel.GetMatchingGroupCount(aux.EnergyAreaFilter(Card.IsColor,COLOR_BLUE),tp,LOCATION_ENERGY,0,nil)>=7 then
		--gain power
		aux.AddTempSkillUpdatePower(c,c,3,10000)
	end
end
