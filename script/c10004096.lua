--BT4-086 Plucky Dynasty Pan
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_PAN)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_EARTHLING,TRAIT_GOKUS_LINEAGE)
	aux.AddEra(c,ERA_BABY_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--swap
	aux.EnableSwap(c,5,aux.FilterBoolFunction(Card.IsSpecialTrait,TRAIT_GOKUS_LINEAGE),aux.PaySkillCost(COLOR_YELLOW,3,0))
	--super combo
	aux.EnableSuperCombo(c)
	--draw, gain skill
	aux.AddSingleAutoSkill(c,0,EVENT_CUSTOM+EVENT_COMBO,nil,scard.op1,nil,scard.con1)
end
--draw, gain skill
function scard.lfilter(c)
	return c:IsColor(COLOR_YELLOW) and c:IsSpecialTrait(TRAIT_GOKUS_LINEAGE)
end
scard.con1=aux.AND(aux.SelfLeaderCondition(scard.lfilter),aux.LifeEqualBelowCondition(PLAYER_SELF,4))
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	--gain combo power
	aux.AddTempSkillUpdateComboPower(c,c,1,10000)
end
