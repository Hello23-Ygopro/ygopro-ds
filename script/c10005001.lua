--BT5-001 Yamcha, the Hungry Wolf
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_YAMCHA)
	aux.AddSpecialTrait(c,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_PILAF_SAGA)
	--leader card
	aux.EnableLeaderAttribute(c)
	--sparking (draw, gain skill)
	aux.EnableSparking(c)
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.op1,nil,aux.SparkingCondition(5))
	--gain skill
	local e1=aux.AddActivateMainSkill(c,1,scard.op2,nil,scard.tg1,EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
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
--gain skill
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(Card.IsColor,COLOR_RED),LOCATION_BATTLE,0,1,1,HINTMSG_TARGET)
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) then return end
	--attack active
	aux.AddTempSkillCustom(e:GetHandler(),tc,3,EFFECT_ATTACK_ACTIVE_MODE)
end
