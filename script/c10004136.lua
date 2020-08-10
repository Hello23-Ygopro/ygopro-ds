--BT4-123 Distant Descendant, Son Goku Jr.
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,4)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_SON_GOKU_JR)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_EARTHLING,TRAIT_GOKUS_LINEAGE)
	aux.AddEra(c,ERA_SPECIAL)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOKU)
	--battle card
	aux.EnableBattleAttribute(c)
	--ultimate
	aux.EnableUltimate(c)
	--triple strike
	aux.EnableTripleStrike(c)
	--combo, drop
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--combo, drop
function scard.tcfilter(c,e,tp)
	return c:IsSpecialTrait(TRAIT_GOKUS_LINEAGE) and c:IsCanCombo(tp) and c:IsCanBeEffectTarget(e)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	local g=Duel.GetDecktopGroup(tp,7)
	Duel.ConfirmCards(tp,g)
	local ct=g:FilterCount(scard.tcfilter,nil,e,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_COMBO)
	local sg=g:FilterSelect(tp,scard.tcfilter,0,ct,nil,e,tp)
	Duel.SetTargetCard(sg)
end
function scard.dropfilter(c,e)
	return c:IsAbleToDrop() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if not g1 then return end
	local sg=g1:Filter(Card.IsRelateToEffect,nil,e)
	if Duel.SendtoCombo(e:GetHandler(),sg,tp,REASON_EFFECT)==0 then return end
	if sg:GetClassCount(Card.GetCode)<5 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DROP)
	local g2=Duel.SelectMatchingCard(tp,aux.LifeAreaFilter(scard.dropfilter),tp,0,LOCATION_LIFE,0,2,nil,e)
	if g2:GetCount()==0 then return end
	Duel.SetTargetCard(g2)
	Duel.SendtoDrop(g2,REASON_EFFECT)
end
