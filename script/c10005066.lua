--BT5-054 Super 17, Evil Entwined
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_SUPER_17)
	aux.AddSpecialTrait(c,TRAIT_ANDROID,TRAIT_MACHINE_MUTANT)
	aux.AddEra(c,ERA_SUPER_17_SAGA)
	--leader card
	aux.EnableLeaderAttribute(c)
	--sparking (draw, gain skill)
	aux.EnableSparking(c)
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.op1,nil,aux.SparkingCondition(5))
	--drop
	aux.AddActivateMainSkill(c,1,scard.op2,nil,nil,nil,aux.HandEqualAboveCondition(PLAYER_OPPO,10))
end
scard.front_side_code=sid-1
--sparking (draw, gain skill)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	--critical
	aux.AddTempSkillCritical(c,c,2)
end
--drop
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local f=aux.HandFilter(Card.IsAbleToDrop)
	local ct=Duel.GetMatchingGroupCount(f,tp,0,LOCATION_HAND,nil)
	if ct<=9 then return end
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_DROP)
	local g=Duel.SelectMatchingCard(1-tp,f,1-tp,LOCATION_HAND,0,ct-9,ct-9,nil)
	Duel.SendtoDrop(g,REASON_EFFECT)
end
