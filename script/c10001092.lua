--BT1-081 Broly's Ring
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,1)
	--extra card
	aux.EnableExtraAttribute(c)
	--field
	aux.EnableField(c)
	--immune
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetRange(LOCATION_FIELD)
	e1:SetTargetRange(LOCATION_HAND,0)
	e1:SetValue(scard.skfilter)
	c:RegisterEffect(e1)
end
--immune
function scard.skfilter(e,te)
	local tc=te:GetHandler()
	return tc:IsControler(e:GetHandlerPlayer()) and tc:IsLeader() and tc:IsCharacter(CHARACTER_BROLY)
end
