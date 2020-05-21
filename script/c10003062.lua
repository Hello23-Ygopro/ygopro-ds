--BT3-056 Thirst for Destruction, Android 13
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_ANDROID_13)
	aux.AddSpecialTrait(c,TRAIT_ANDROID)
	aux.AddEra(c,ERA_ANDROID_13_SAGA)
	aux.AddCategory(c,NAME_CATEGORY_ANDROID)
	--leader card
	aux.EnableLeaderAttribute(c)
	--gain skill
	aux.AddAutoSkill(c,0,EVENT_DROP,nil,scard.op1,nil,scard.con1)
	--draw
	aux.AddSingleAutoSkill(c,1,EVENT_ATTACK_ANNOUNCE,nil,aux.DuelOperation(Duel.Draw,PLAYER_SELF,1,REASON_EFFECT))
end
scard.front_side_code=sid-1
--gain skill
function scard.cfilter(c,tp)
	return (c:IsCharacter(CHARACTER_SON_GOKU) or (c:IsBattle() and c:IsEnergyBelow(6))) and c:GetPreviousControler()==1-tp
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(scard.cfilter,1,nil,tp) and re and bit.band(r,REASON_EFFECT)~=0 and rp==tp
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	--critical
	aux.AddTempSkillCritical(c,c,2)
end
