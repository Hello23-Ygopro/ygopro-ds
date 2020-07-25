--BT2-083 Martial Expert Tien Shinhan
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_TIEN_SHINHAN)
	aux.AddSpecialTrait(c,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_ANDROID_CELL_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--play
	aux.AddSingleAutoSkill(c,0,EVENT_CUSTOM+EVENT_COMBO_END,nil,aux.SelfPlayOperation(POS_FACEUP_ACTIVE),nil,scard.con1)
	--to hand, ko
	aux.AddActivateMainSkill(c,1,scard.op1,scard.cost1,scard.tg1,EFFECT_FLAG_CARD_TARGET)
end
scard.specified_cost={COLOR_GREEN,2}
scard.combo_cost=2
--play
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return aux.SelfLeaderCondition(Card.IsColor,COLOR_GREEN)(e,tp,eg,ep,ev,re,r,rp)
		and not e:GetHandler():IsPreviousLocation(LOCATION_BATTLE)
end
--to hand, ko
scard.cost1=aux.DropCost(aux.LifeAreaFilter(nil),LOCATION_LIFE,0,1)
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.LifeAreaFilter(Card.IsAbleToHand),LOCATION_LIFE,0,1,1,HINTMSG_ATOHAND)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,PLAYER_OWNER,REASON_EFFECT)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_KO)
	local g=Duel.SelectMatchingCard(tp,aux.BattleAreaFilter(Card.IsCanBeEffectTarget),tp,0,LOCATION_BATTLE,0,1,nil,e)
	if g:GetCount()==0 then return end
	Duel.BreakEffect()
	Duel.SetTargetCard(g)
	Duel.KO(g,REASON_EFFECT)
end
