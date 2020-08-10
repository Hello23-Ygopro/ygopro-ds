--BT4-092 Multimech Bulma
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_BULMA)
	aux.AddSpecialTrait(c,TRAIT_SPECIAL_MODEL_KIT)
	aux.AddEra(c,ERA_SPECIAL)
	--battle card
	aux.EnableBattleAttribute(c)
	--ex-evolve
	aux.EnableEXEvolve(c,scard.evofilter,aux.PaySkillCost(COLOR_YELLOW,1,1))
	--drop, untap, draw
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PLAY)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetOperation(scard.regop)
	c:RegisterEffect(e1)
	aux.AddAutoSkill(c,0,EVENT_PHASE+PHASE_END,nil,scard.op1,nil,scard.con1)
end
--ex-evolve
function scard.evofilter(c)
	return c:IsCharacter(CHARACTER_BULMA) and c:IsEnergyAbove(3)
end
--drop, untap, draw
function scard.regop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RegisterFlagEffect(sid,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,1)
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(sid)>0
end
function scard.untfilter(c,e)
	return c:IsAbleToSwitchToActive() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendDecktoptoDropUpTo(tp,2,REASON_EFFECT)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOACTIVE)
	local g=Duel.SelectMatchingCard(tp,aux.EnergyAreaFilter(scard.untfilter),tp,LOCATION_ENERGY,0,0,1,nil,e)
	if g:GetCount()>0 then
		Duel.BreakEffect()
		Duel.SetTargetCard(g)
		Duel.SwitchtoActive(g,REASON_EFFECT)
	end
	Duel.Draw(tp,1,REASON_EFFECT)
end
