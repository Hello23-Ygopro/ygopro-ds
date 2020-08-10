--BT3-052 The Most Evil Absorption in History
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,2)
	--extra card
	aux.EnableExtraAttribute(c)
	--absorb
	aux.AddActivateMainSkill(c,0,scard.op1,nil,scard.tg1,EFFECT_FLAG_CARD_TARGET,aux.SelfLeaderCondition(Card.IsCharacter,CHARACTER_MAJIN_BUU))
end
--absorb
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,aux.FaceupFilter(Card.IsCharacter,CHARACTER_MAJIN_BUU),tp,LOCATION_INPLAY,0,1,1,nil)
	e:SetLabelObject(g:GetFirst())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ABSORB)
	Duel.SelectTarget(tp,aux.BattleAreaFilter(nil),tp,0,LOCATION_BATTLE,1,1,nil)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc1=e:GetLabelObject()
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if not tc1 or not g then return end
	local tc2=g:GetFirst()
	if tc2==tc1 then tc2=g:GetNext() end
	if tc1:IsRelateToEffect(e) and tc1:IsFaceup() and tc2 and tc2:IsRelateToEffect(e) and tc2:IsFaceup() then
		Duel.PlaceUnder(tc1,tc2)
	end
end
