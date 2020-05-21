--BT5-101 Time Magic
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--extra card
	aux.EnableExtraAttribute(c)
	--negate attack, gain skill
	aux.AddCounterAttackSkill(c,0,scard.op1,scard.cost1,nil,EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_IGNORE_BARRIER,scard.con1)
	--sparking
	aux.EnableSparking(c)
end
scard.specified_cost={COLOR_YELLOW,1}
--negate attack, gain skill
scard.con1=aux.SelfLeaderCondition(Card.IsColor,COLOR_YELLOW)
function scard.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local c=e:GetHandler()
	if aux.SparkingCondition(5)(e,tp,eg,ep,ev,re,r,rp)
		and Duel.IsExistingMatchingCard(aux.LifeAreaFilter(Card.IsAbleToHand),tp,LOCATION_LIFE,0,1,nil)
		and Duel.SelectYesNo(tp,aux.Stringid(sid,2)) then
		Duel.Hint(HINT_OPSELECTED,1-tp,aux.Stringid(sid,1))
		Duel.SendtoDrop(c,REASON_RULE)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.SelectMatchingCard(tp,aux.LifeAreaFilter(Card.IsAbleToHand),tp,LOCATION_LIFE,0,1,1,nil)
		Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
		--activate without paying
		aux.AddTempSkillCustom(c,c,3,EFFECT_ACTIVATE_WITHOUT_PAYING,RESET_CHAIN)
	end
end
function scard.skfilter(c,e)
	return c:IsRest() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectMatchingCard(tp,aux.BattleAreaFilter(scard.skfilter),tp,0,LOCATION_BATTLE,0,1,nil,e)
	if g:GetCount()==0 then return end
	Duel.BreakEffect()
	Duel.SetTargetCard(g)
	--cannot switch to active
	aux.AddTempSkillCustom(e:GetHandler(),g:GetFirst(),4,EFFECT_CANNOT_CHANGE_POS_E,RESET_PHASE+PHASE_DRAW+RESET_SELF_TURN,1,aux.SelfRestCondition)
end
