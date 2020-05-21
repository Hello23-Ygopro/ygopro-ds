--BT5-115 Power Burst
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--extra card
	aux.EnableExtraAttribute(c)
	--negate attack, to hand
	aux.AddCounterAttackSkill(c,0,scard.op1,scard.cost1,nil,EFFECT_FLAG_CARD_TARGET,scard.con1)
	--sparking
	aux.EnableSparking(c)
end
--negate attack, to hand
scard.con1=aux.SelfLeaderCondition(Card.IsColor,COLOR_BLACK)
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
function scard.thfilter(c,e)
	return c:IsBattle() and c:IsColor(COLOR_BLACK) and c:IsEnergy(1) and c:IsAbleToHand() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
	local g1=Duel.GetMatchingGroup(scard.thfilter,tp,LOCATION_DROP,0,nil,e)
	local g2=Duel.GetMatchingGroup(scard.thfilter,tp,LOCATION_WARP,0,nil,e)
	g1:Merge(g2)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local sg=g1:Select(tp,0,1,nil)
	if sg:GetCount()==0 then return end
	Duel.BreakEffect()
	Duel.SetTargetCard(sg)
	Duel.SendtoHand(sg,PLAYER_OWNER,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,sg)
end
