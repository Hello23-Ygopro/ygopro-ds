--TB1-048 Dangers Triangle
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,1)
	--extra card
	aux.EnableExtraAttribute(c)
	--field
	aux.EnableField(c)
	--negate skill
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_DISABLE)
	e1:SetRange(LOCATION_FIELD)
	e1:SetTargetRange(0,LOCATION_BATTLE)
	e1:SetCondition(scard.con1)
	e1:SetTarget(scard.tg1)
	c:RegisterEffect(e1)
end
--negate skill
function scard.con1(e)
	local tp=e:GetHandlerPlayer()
	return Duel.IsExistingMatchingCard(aux.BattleAreaFilter(Card.IsCharacter,CHARACTER_BERGAMO),tp,LOCATION_BATTLE,0,1,nil)
		and Duel.IsExistingMatchingCard(aux.BattleAreaFilter(Card.IsCharacter,CHARACTER_LAVENDER),tp,LOCATION_BATTLE,0,1,nil)
		and Duel.IsExistingMatchingCard(aux.BattleAreaFilter(Card.IsCharacter,CHARACTER_BASIL),tp,LOCATION_BATTLE,0,1,nil)
end
function scard.tg1(e,c)
	return c:IsBattle() and c:IsEnergyBelow(4)
end
