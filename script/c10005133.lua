--BT5-112 Dark Power Black Masked Saiyan
--UNTESTED in non-puzzle mode: Only triggers in puzzle mode if its master plays a battle card.
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_BLACK_MASKED_SAIYAN)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_DARK_DEMON_REALM_SAGA)
	aux.AddCategory(c,NAME_CATEGORY_MASKED)
	--battle card
	aux.EnableBattleAttribute(c)
	--to hand, gain skill
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.op1)
	--drop
	aux.AddAutoSkill(c,1,EVENT_PLAY,scard.tg1,scard.op2,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
scard.combo_cost=0
--to hand, gain skill
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,aux.LifeAreaFilter(Card.IsAbleToHand),tp,LOCATION_LIFE,0,0,1,nil)
	if g:GetCount()==0 or Duel.SendtoHand(g,REASON_EFFECT)==0 then return end
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	--gain power
	aux.AddTempSkillUpdatePower(c,c,2,10000)
end
--drop
function scard.cfilter(c,tp)
	return c:IsPowerBelow(15000) and c:GetPlayPlayer()~=tp
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(aux.BattleAreaFilter(scard.cfilter),1,nil,tp)
		and re and not re:IsHasProperty(EFFECT_FLAG_KEYSKILL)
end
scard.tg1=aux.TargetCardFunction(PLAYER_OPPO,aux.HandFilter(Card.IsAbleToDrop),0,LOCATION_HAND,2,2,HINTMSG_DROP)
scard.op2=aux.TargetCardsOperation(Duel.SendtoDrop,REASON_EFFECT)
