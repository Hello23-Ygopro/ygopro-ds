--EX03-24 Clownish Destruction Belmod
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_BELMOD)
	aux.AddSpecialTrait(c,TRAIT_GOD,TRAIT_UNIVERSE_11)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,TRAIT_CATEGORY_UNIVERSE)
	--battle card
	aux.EnableBattleAttribute(c)
	--barrier
	aux.EnableBarrier(c)
	--double strike
	aux.EnableDoubleStrike(c)
	--to hand, drop or ko
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
scard.specified_cost={COLOR_YELLOW,2}
scard.combo_cost=0
--to hand, drop or ko
function scard.thfilter(c,e)
	return c:IsAbleToHand() and c:IsCanBeEffectTarget(e)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_DECK) and chkc:IsControler(tp) and chkc:IsAbleToHand() end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	local g=Duel.GetDecktopGroup(tp,3)
	Duel.ConfirmCards(tp,g)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local sg=g:FilterSelect(tp,scard.thfilter,0,1,nil,e)
	if sg:GetCount()>0 then
		Duel.SetTargetCard(sg)
		e:SetLabel(0)
	else
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_KO)
		Duel.SelectTarget(tp,aux.BattleAreaFilter(Card.IsRest),tp,0,LOCATION_BATTLE,0,1,nil)
		e:SetLabel(1)
	end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) then return end
	local ct=0
	if e:GetLabel()==0 then
		Duel.DisableShuffleCheck()
		ct=ct+Duel.SendtoHand(tc,PLAYER_OWNER,REASON_EFFECT)
		if ct>0 then Duel.ShuffleHand(tp) end
		Duel.SendDecktoptoDrop(tp,3-ct,REASON_EFFECT)
	else
		Duel.KO(tc,REASON_EFFECT)
	end
end
