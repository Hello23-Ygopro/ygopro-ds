--EX03-22 Elite Bloodline Cooler
--Not fully implemented: Cards do not switch to Rest Mode when attacking
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_COOLER)
	aux.AddSpecialTrait(c,TRAIT_FRIEZA_CLAN)
	aux.AddEra(c,ERA_COOLER_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--reduce energy cost
	aux.AddPermanentUpdateEnergyCost(c,-1,nil,aux.ExistingCardCondition(aux.DropAreaFilter(Card.IsSpecialTrait,TRAIT_FRIEZA_CLAN),LOCATION_DROP,0,3))
	--drop, untap
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
--drop, untap
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if not aux.SelfLeaderCondition(Card.IsSpecialTrait,TRAIT_FRIEZA_CLAN)(e,tp,eg,ep,ev,re,r,rp) then return end
	Duel.SendDecktoptoDrop(tp,3,REASON_EFFECT)
	if not Duel.IsExistingMatchingCard(aux.DropAreaFilter(Card.IsSpecialTrait,TRAIT_FRIEZA_CLAN),tp,LOCATION_DROP,0,1,nil) then return end
	Duel.BreakEffect()
	Duel.SwitchtoActive(e:GetHandler(),REASON_EFFECT)
	e:GetHandler():RegisterFlagEffect(sid,RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END,0,1)
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(sid)>0
end
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsAbleToSwitchToActive() then return end
	Duel.Hint(HINT_CARD,0,sid)
	Duel.SwitchtoActive(c,REASON_EFFECT)
	c:ResetFlagEffect(sid)
end
