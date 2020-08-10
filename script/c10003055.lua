--BT3-051 God Absorber Majin Buu
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_MAJIN_BUU)
	aux.AddSpecialTrait(c,TRAIT_MAJIN)
	aux.AddEra(c,ERA_MAJIN_BUU_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--evolve
	aux.EnableEvolve(c,aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_GRAND_SUPREME_KAI),aux.PaySkillCost(COLOR_BLUE,2,2))
	--double strike
	aux.EnableDoubleStrike(c)
	--leave replace
	aux.AddPermanentReplaceLeave(c,0,scard.op1,scard.con1)
end
--leave replace
function scard.con1(e)
	local c=e:GetHandler()
	return c:IsFaceup() and c:GetAbsorbedGroup():IsExists(Card.IsCharacter,1,nil,CHARACTER_GRAND_SUPREME_KAI)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetHandler():GetAbsorbedGroup()
	if not g:IsExists(Card.IsAbleToDrop,1,nil) then return end
	Duel.Hint(HINT_CARD,0,sid)
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.SendtoDrop(g,REASON_EFFECT+REASON_REPLACE)
end
