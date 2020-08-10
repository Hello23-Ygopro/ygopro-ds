--BT1-107 Cold Bloodlust
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,1)
	--extra card
	aux.EnableExtraAttribute(c)
	--negate skill
	aux.AddCounterPlaySkill(c,0,scard.op1,nil,scard.tg1,nil,aux.SelfLeaderCondition(Card.IsSpecialTrait,TRAIT_FRIEZAS_ARMY))
end
--negate skill
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=eg:Filter(aux.BattleAreaFilter(nil),nil)
	if chk==0 then return g:GetCount()>0 end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.SetTargetCard(g)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if not g then return end
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	for tc in aux.Next(sg) do
		--negate skill
		aux.AddTempSkillNegateSkill(e:GetHandler(),tc,1)
	end
end
