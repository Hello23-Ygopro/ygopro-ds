--BT3-080 Create Android
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCategory(c,NAME_CATEGORY_ANDROID)
	--extra card
	aux.EnableExtraAttribute(c)
	--draw, drop
	aux.AddActivateMainSkill(c,0,scard.op1,nil,nil,nil,aux.SelfLeaderCondition(Card.IsSpecialTrait,TRAIT_ANDROID))
end
scard.specified_cost={COLOR_GREEN,1}
--draw, drop
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.Draw(tp,2,REASON_EFFECT)>0 then Duel.ShuffleHand(tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DROP)
	local g=Duel.SelectMatchingCard(tp,aux.HandFilter(Card.IsAbleToDrop),tp,LOCATION_HAND,0,1,1,e:GetHandler())
	if g:GetCount()==0 then return end
	Duel.BreakEffect()
	Duel.SendtoDrop(g,REASON_EFFECT)
end
