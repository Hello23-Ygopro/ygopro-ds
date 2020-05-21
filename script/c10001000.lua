--BT1-001 Champa
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_CHAMPA)
	aux.AddSpecialTrait(c,TRAIT_GOD)
	aux.AddEra(c,ERA_CHAMPA_SAGA)
	--leader card
	aux.EnableLeaderAttribute(c)
	--draw
	local e1=aux.AddAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.op1,nil,scard.con1)
	e1:SetCountLimit(1)
	--awaken
	aux.EnableAwaken(c)
end
scard.back_side_code=sid+1
--draw
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	return a and a:IsBattle() and a:IsControler(tp) and d and d:IsFaceup() and d:IsLeader()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if scard.con1(e,tp,eg,ep,ev,re,r,rp) and Duel.GetAttacker():IsPowerAbove(15000) then
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
