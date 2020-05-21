--BT3-082 Unwavering Justice Bardock
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_BARDOCK)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_BARDOCK_SAGA)
	--leader card
	aux.EnableLeaderAttribute(c)
	--draw
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,aux.DuelOperation(Duel.Draw,PLAYER_SELF,1,REASON_EFFECT))
	--gain skill
	local e1=aux.AddAutoSkill(c,1,EVENT_KOED,nil,scard.op1,nil,scard.con1)
	e1:SetCountLimit(1)
end
scard.front_side_code=sid-1
--gain skill
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(aux.FilterEqualFunction(Card.GetPreviousControler,tp),nil)
	g:KeepAlive()
	e:SetLabelObject(g)
	return g:GetCount()>0
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=e:GetLabelObject()
	if c:IsRelateToEffect(e) and c:IsFaceup() and g:IsExists(Card.IsSpecialTrait,1,nil,TRAIT_SAIYAN) then
		--gain power
		aux.AddTempSkillUpdatePower(c,c,2,5000)
	end
end
