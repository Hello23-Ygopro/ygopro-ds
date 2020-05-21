--BT3-069 Unending Destruction, Android 13
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_ANDROID_13)
	aux.AddSpecialTrait(c,TRAIT_ANDROID)
	aux.AddEra(c,ERA_ANDROID_13_SAGA)
	aux.AddCategory(c,NAME_CATEGORY_ANDROID)
	--battle card
	aux.EnableBattleAttribute(c)
	--double strike
	aux.EnableDoubleStrike(c)
	--ko
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
	--drop
	aux.AddAutoSkill(c,1,EVENT_DROP,scard.tg2,scard.op2,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
scard.specified_cost={COLOR_GREEN,4}
scard.combo_cost=1
--ko
scard.tg1=aux.TargetCardFunction(PLAYER_OPPO,aux.BattleAreaFilter(nil),0,LOCATION_BATTLE,1,1,HINTMSG_KO)
scard.op1=aux.TargetCardsOperation(Duel.KO,REASON_EFFECT)
--drop
function scard.cfilter(c,tp)
	return c:IsBattle() and c:GetPreviousControler()==1-tp
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(scard.cfilter,1,nil,tp)
		and re and re:GetHandler()~=e:GetHandler() and bit.band(r,REASON_EFFECT)~=0 and rp==tp
end
scard.tg2=aux.TargetCardFunction(PLAYER_OPPO,aux.HandFilter(Card.IsAbleToDrop),0,LOCATION_HAND,1,1,HINTMSG_DROP)
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and c:IsFaceup() and tc and tc:IsRelateToEffect(e) then
		Duel.SendtoDrop(tc,REASON_EFFECT)
	end
end
