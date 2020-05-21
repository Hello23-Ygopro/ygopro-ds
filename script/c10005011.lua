--BT5-009_SPR Yamcha, at 100% (Alias)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_YAMCHA)
	aux.AddSpecialTrait(c,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_PILAF_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--burst (gain skill)
	aux.EnableBurst(c)
	local e1=aux.AddActivateMainSkill(c,0,scard.op1,aux.BurstCost(5),nil,nil,aux.SelfLeaderCondition(scard.lfilter))
	e1:SetCountLimit(1)
end
scard.specified_cost={COLOR_RED,2}
scard.combo_cost=0
--burst (gain skill)
function scard.lfilter(c)
	return c:IsColor(COLOR_RED) and c:IsSpecialTrait(TRAIT_EARTHLING)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	--gain power
	aux.AddTempSkillUpdatePower(c,c,2,6000)
	--cannot negate attack
	aux.AddTempSkillCustom(c,c,3,EFFECT_CANNOT_NEGATE_ATTACK)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,1))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_BATTLE_KOING)
	e1:SetOperation(scard.op2)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
	c:RegisterEffect(e1)
end
--damage
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,sid)
	Duel.Damage(1-tp,2,REASON_EFFECT)
end
