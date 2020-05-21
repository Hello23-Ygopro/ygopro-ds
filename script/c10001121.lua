--BT1-106 Recoome Eraser Gun
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--extra card
	aux.EnableExtraAttribute(c)
	--negate attack, gain skill
	aux.AddCounterAttackSkill(c,0,scard.op1)
end
scard.specified_cost={COLOR_YELLOW,2}
--negate attack, gain skill
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if aux.SelfLeaderCondition(Card.IsColor,COLOR_YELLOW)(e,tp,eg,ep,ev,re,r,rp) then
		Duel.NegateAttack()
	end
	Duel.BreakEffect()
	local c=e:GetHandler()
	--cannot attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
	e1:SetTargetRange(0,LOCATION_BATTLE)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsBattle))
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(sid,1))
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CLIENT_HINT)
	e2:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e2,tp)
end
