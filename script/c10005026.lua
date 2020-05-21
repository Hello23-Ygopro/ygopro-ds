--BT5-023 Afterimage Technique
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--extra card
	aux.EnableExtraAttribute(c)
	--gain skill
	aux.AddCounterAttackSkill(c,0,scard.op1,scard.cost1,scard.tg1,EFFECT_FLAG_CARD_TARGET,scard.con1)
	--sparking
	aux.EnableSparking(c)
end
scard.specified_cost={COLOR_RED,1}
--gain skill
scard.con1=aux.SelfLeaderCondition(Card.IsColor,COLOR_RED)
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
function scard.powfilter(c)
	return c:IsLeader() or c:IsBattle()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.FaceupFilter(scard.powfilter),LOCATION_INPLAY,0,0,1,HINTMSG_TARGET)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		--gain power
		aux.AddTempSkillUpdatePower(c,tc,4,40000,RESET_PHASE+PHASE_DAMAGE)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectMatchingCard(tp,aux.BattleAreaFilter(Card.IsCanBeEffectTarget),tp,0,LOCATION_BATTLE,0,1,nil,e)
	if g:GetCount()==0 then return end
	Duel.BreakEffect()
	Duel.SetTargetCard(g)
	--lose power
	aux.AddTempSkillUpdatePower(c,g:GetFirst(),5,-10000)
end
