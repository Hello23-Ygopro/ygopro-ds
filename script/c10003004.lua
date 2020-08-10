--BT3-003 Victorious Fist Super Saiyan 3 Son Goku
--Not fully implemented: Cards do not switch to Rest Mode when attacking
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_RED,3)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_SON_GOKU_GT)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_BABY_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_GT,CHAR_CATEGORY_SON_GOKU)
	--battle card
	aux.EnableBattleAttribute(c)
	--ex-evolve
	aux.EnableEXEvolve(c,scard.evofilter,aux.MergeCost(aux.PaySkillCost(COLOR_RED,1,0),aux.DropCost(aux.HandFilter(nil),LOCATION_HAND,0,1)))
	--double strike
	aux.EnableDoubleStrike(c)
	--untap, gain skill
	local e1=aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.op1)
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
--ex-evolve
function scard.evofilter(c)
	return c:IsColor(COLOR_RED) and c:IsCharacter(CHARACTER_SON_GOKU_GT) and c:IsEnergyAbove(5)
end
--untap, gain skill
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	--gain power
	aux.AddTempSkillUpdatePower(c,c,1,5000)
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
