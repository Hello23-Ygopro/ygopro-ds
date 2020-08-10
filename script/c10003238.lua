--TB01-077 Frieza, Emperor of Universe 7
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,2)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_FRIEZA)
	aux.AddSpecialTrait(c,TRAIT_FRIEZA_CLAN,TRAIT_UNIVERSE_7)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,TRAIT_CATEGORY_UNIVERSE)
	--battle card
	aux.EnableBattleAttribute(c)
	--ex-evolve
	aux.EnableEXEvolve(c,scard.evofilter,scard.cost1)
	--triple strike
	aux.EnableTripleStrike(c)
	--activate cost
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_ACTIVATE_COST)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(LOCATION_BATTLE)
	e1:SetTargetRange(0,1)
	e1:SetCondition(aux.AND(aux.SelfLeaderCondition(Card.IsColor,COLOR_YELLOW),scard.con1))
	e1:SetCost(scard.cost2)
	e1:SetTarget(scard.tg1)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
end
--ex-evolve
function scard.evofilter(c)
	return c:IsSpecialTrait(TRAIT_UNIVERSE_7) and c:IsEnergyAbove(5)
end
scard.cost1=aux.MergeCost(aux.PaySkillCost(COLOR_COLORLESS,0,1),aux.DropCost(aux.HandFilter(Card.IsSpecialTrait,TRAIT_UNIVERSE_7),LOCATION_HAND,0,1))
--activate cost
function scard.con1(e)
	scard[0]=false
	return true
end
function scard.cost2(e,te,tp)
	return Duel.IsExistingMatchingCard(aux.LifeAreaFilter(Card.IsAbleToDrop),tp,LOCATION_LIFE,0,1,nil)
end
function scard.tg1(e,te,tp)
	return te:IsHasCategory(CATEGORY_COUNTER+CATEGORY_AUTO+CATEGORY_ACTIVATE)
		and not te:IsHasProperty(EFFECT_FLAG_KEYSKILL)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if scard[0] then return end
	Duel.Hint(HINT_CARD,0,sid)
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DROP)
	local g=Duel.SelectMatchingCard(tp,aux.LifeAreaFilter(Card.IsAbleToDrop),tp,LOCATION_LIFE,0,1,1,nil)
	Duel.SendtoDrop(g,REASON_EFFECT)
	scard[0]=true
end
--[[
	References
	* Tyrant's Tantrum
	https://github.com/Fluorohydride/ygopro-scripts/blob/6324c1c/c38318146.lua#L9
]]
