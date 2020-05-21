--BT1-085 Ginyu, The Malicious Transformation
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_GINYU)
	aux.AddSpecialTrait(c,TRAIT_GINYU_FORCE,TRAIT_FRIEZAS_ARMY)
	aux.AddEra(c,ERA_FRIEZA_SAGA)
	--leader card
	aux.EnableLeaderAttribute(c)
	--gain skill
	local e1=aux.AddActivateMainSkill(c,0,scard.op1,scard.cost1)
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
	if Duel.IsExistingMatchingCard(aux.FaceupFilter(Card.IsSpecialTrait,TRAIT_GINYU_FORCE),tp,LOCATION_INPLAY,0,2,nil) then
		--gain power
		aux.AddTempSkillUpdatePower(c,c,3,5000)
	end
end
