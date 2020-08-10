--BT4-070 Sacrifice
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,1)
	--extra card
	aux.EnableExtraAttribute(c)
	--drop, negate attack
	aux.AddCounterAttackSkill(c,0,scard.op1,scard.cost1,nil,EFFECT_FLAG_CARD_TARGET)
end
--drop, negate attack
function scard.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local c=e:GetHandler()
	if aux.SelfLeaderCondition(Card.IsSpecialTrait,TRAIT_NAMEKIAN)(e,tp,eg,ep,ev,re,r,rp)
		and Duel.IsExistingTarget(aux.LifeAreaFilter(Card.IsAbleToHand),tp,LOCATION_LIFE,0,1,nil)
		and Duel.SelectYesNo(tp,aux.Stringid(sid,2)) then
		Duel.Hint(HINT_OPSELECTED,1-tp,aux.Stringid(sid,1))
		Duel.SendtoDrop(c,REASON_RULE)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.SelectTarget(tp,aux.LifeAreaFilter(Card.IsAbleToHand),tp,LOCATION_LIFE,0,1,1,nil)
		Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
		--activate without paying
		aux.AddTempSkillCustom(c,c,3,EFFECT_ACTIVATE_WITHOUT_PAYING,RESET_CHAIN)
		Duel.ClearTargetCard()
	end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
end
