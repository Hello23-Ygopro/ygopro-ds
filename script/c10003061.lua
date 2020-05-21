--BT3-056 Android 13
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_ANDROID_13)
	aux.AddSpecialTrait(c,TRAIT_ANDROID)
	aux.AddEra(c,ERA_ANDROID_13_SAGA)
	aux.AddCategory(c,NAME_CATEGORY_ANDROID)
	--leader card
	aux.EnableLeaderAttribute(c)
	--change awaken life
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CHANGE_AWAKEN_LIFE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(LOCATION_LEADER)
	e1:SetTargetRange(1,0)
	e1:SetCondition(scard.con1)
	e1:SetValue(6)
	c:RegisterEffect(e1)
	--awaken
	aux.EnableAwaken(c)
end
scard.back_side_code=sid+1
--change awaken life
function scard.con1(e)
	local tp=e:GetHandlerPlayer()
	return Duel.IsExistingMatchingCard(aux.DropAreaFilter(Card.IsCharacter,CHARACTER_ANDROID_14),tp,LOCATION_DROP,0,1,nil)
		and Duel.IsExistingMatchingCard(aux.DropAreaFilter(Card.IsCharacter,CHARACTER_ANDROID_15),tp,LOCATION_DROP,0,1,nil)
		and Duel.GetLifeCount(tp)<=6
end
