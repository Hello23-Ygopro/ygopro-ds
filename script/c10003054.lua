--BT3-050 Majin Buu, Dawn of the Rampage
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_MAJIN_BUU)
	aux.AddSpecialTrait(c,TRAIT_MAJIN)
	aux.AddEra(c,ERA_MAJIN_BUU_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--union-absorb
	aux.EnableUnionAbsorb(c,aux.FilterBoolFunction(Card.IsCode,CARD_AWAKENING_EVIL_MAJIN_BUU),scard.cost1)
	--barrier
	aux.EnableBarrier(c)
	--gain skill
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_ABSORB)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
end
scard.specified_cost={COLOR_BLUE,1}
scard.combo_cost=0
--union-absorb
scard.cost1=aux.MergeCost(aux.PaySkillCost(COLOR_COLORLESS,0,2),aux.AbsorbCost(aux.HandFilter(Card.IsBattle),LOCATION_HAND,0,0,1))
--gain skill
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	--barrier
	aux.AddTempSkillBarrier(c,c:GetReasonCard(),0,0)
end
