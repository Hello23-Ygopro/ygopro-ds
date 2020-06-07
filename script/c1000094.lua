--P-080 Super 17, the Infernal Machine
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_SUPER_17)
	aux.AddSpecialTrait(c,TRAIT_ANDROID,TRAIT_MACHINE_MUTANT)
	aux.AddEra(c,ERA_SUPER_17_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--double strike
	aux.EnableDoubleStrike(c)
	--cannot negate attack
	aux.AddSinglePermanentSkill(c,EFFECT_CANNOT_NEGATE_ATTACK)
	--drop
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
scard.specified_cost={COLOR_GREEN,3}
scard.combo_cost=0
--drop
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	if not Duel.IsExistingTarget(aux.HandFilter(Card.IsAbleToDrop),tp,LOCATION_HAND,0,2,nil)
		or not Duel.SelectYesNo(tp,YESNOMSG_DROP) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DROP)
	Duel.SelectTarget(tp,aux.HandFilter(Card.IsAbleToDrop),tp,LOCATION_HAND,0,2,2,nil)
end
function scard.dropfilter(c,e)
	return c:IsAbleToDrop() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if not g1 then return end
	local sg=g1:Filter(Card.IsRelateToEffect,nil,e)
	if Duel.SendtoDrop(sg,REASON_EFFECT)==0 then return end
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_DROP)
	local g2=Duel.SelectMatchingCard(1-tp,aux.HandFilter(scard.dropfilter),1-tp,LOCATION_HAND,0,2,2,nil,e)
	if g2:GetCount()==0 then return end
	Duel.SetTargetCard(g2)
	Duel.SendtoDrop(g2,REASON_EFFECT)
end
