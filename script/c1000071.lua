--P-063 Glory-Obsessed Prince of Destruction Vegeta
--Not fully implemented: Cards do not switch to Rest Mode when attacking
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_RED,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_VEGETA)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_MAJIN_BUU_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--attack active
	aux.AddSinglePermanentSkill(c,EFFECT_ATTACK_ACTIVE_MODE,aux.SelfLeaderCondition(Card.IsColor,COLOR_RED))
	--untap, gain skill
	local e1=aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.op1,nil,aux.SelfAttackTargetCondition(Card.IsBattle))
	e1:SetCountLimit(1)
	--workaround to untap
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_CUSTOM+EVENT_ATTACK_END)
	e2:SetCountLimit(1)
	e2:SetCondition(scard.con1)
	e2:SetOperation(scard.op2)
	c:RegisterEffect(e2)
end
--untap, gain skill
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	--gain power
	aux.AddTempSkillUpdatePower(c,c,1,10000,RESET_PHASE+PHASE_DAMAGE)
	c:RegisterFlagEffect(sid,RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END,0,1)
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(sid)>0
end
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsAbleToSwitchToActive() then return end
	Duel.Hint(HINT_CARD,0,sid)
	Duel.SwitchtoActive(c,REASON_EFFECT)
end
