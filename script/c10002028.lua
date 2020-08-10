--BT2-025 Grand Evil Absorption Majin Buu
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_RED,2)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_MAJIN_BUU)
	aux.AddSpecialTrait(c,TRAIT_MAJIN)
	aux.AddEra(c,ERA_MAJIN_BUU_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--evolve
	aux.EnableEvolve(c,aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_SON_GOHAN_ADOLESCENCE),aux.PaySkillCost(COLOR_RED,3,3))
	--dual attack
	aux.EnableDualAttack(c)
	--gain skill
	local e1=aux.AddActivateMainSkill(c,0,scard.op1,scard.cost1,nil,EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
end
--gain skill
function scard.costfilter(c,e)
	return c:IsCharacter(CHARACTER_SON_GOHAN_ADOLESCENCE) and c:IsCanBeEffectTarget(e)
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
	--attack active
	local e1=aux.AddTempSkillCustom(c,c,1,EFFECT_ATTACK_ACTIVE_MODE)
	--copy skill
	local reset_flag=RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END
	local cid=c:CopyEffect(tc:GetCode(),reset_flag,1)
	c:RegisterFlagEffect(0,reset_flag,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(sid,2))
	--reset skill
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(sid,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_BATTLE)
	e2:SetCountLimit(1)
	e2:SetLabel(cid)
	e2:SetLabelObject(e1)
	e2:SetOperation(scard.op2)
	e2:SetReset(reset_flag)
	c:RegisterEffect(e2)
end
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local cid=e:GetLabel()
	c:ResetEffect(cid,RESET_COPY)
	local e1=e:GetLabelObject()
	e1:Reset()
	Duel.HintSelection(Group.FromCards(c))
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
