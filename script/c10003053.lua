--BT3-049 Power Absorbing Majin Buu
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_MAJIN_BUU)
	aux.AddSpecialTrait(c,TRAIT_MAJIN)
	aux.AddEra(c,ERA_MAJIN_BUU_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--evolve
	aux.EnableEvolve(c,aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_SOUTH_SUPREME_KAI),aux.PaySkillCost(COLOR_BLUE,2,2))
	--dual attack
	aux.EnableDualAttack(c)
	--gain skill
	local e1=aux.AddActivateMainSkill(c,0,scard.op1,scard.cost1,nil,EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
end
scard.specified_cost={COLOR_BLUE,2}
scard.combo_cost=1
--gain skill
function scard.costfilter(c,e)
	return c:IsCharacter(CHARACTER_SOUTH_SUPREME_KAI) and c:IsCanBeEffectTarget(e)
end
function scard.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=e:GetHandler():GetAbsorbedGroup()
	if chk==0 then return g:IsExists(scard.costfilter,1,nil,e) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local sg=g:FilterSelect(tp,scard.costfilter,1,1,nil,e)
	if sg:GetCount()==0 then return end
	Duel.SetTargetCard(sg:GetFirst())
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() or not tc or not tc:IsRelateToEffect(e) then return end
	--copy skill
	local reset_flag=RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END
	local cid=c:CopyEffect(tc:GetCode(),reset_flag,1)
	c:RegisterFlagEffect(0,reset_flag,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(sid,1))
	--reset skill
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_BATTLE)
	e1:SetCountLimit(1)
	e1:SetLabel(cid)
	e1:SetOperation(scard.op2)
	e1:SetReset(reset_flag)
	c:RegisterEffect(e1)
end
--reset skill
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local cid=e:GetLabel()
	c:ResetEffect(cid,RESET_COPY)
	e:Reset()
	Duel.HintSelection(Group.FromCards(c))
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
