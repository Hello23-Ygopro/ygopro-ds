--BT2-003 Babidi, Creator of Evil
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_EVIL_WIZARD_BABIDI)
	aux.AddSpecialTrait(c,TRAIT_EVIL_WIZARD)
	aux.AddEra(c,ERA_THE_EVIL_WIZARD_BABIDI_SAGA)
	--leader card
	aux.EnableLeaderAttribute(c)
	--gain skill
	local e1=aux.AddActivateMainSkill(c,0,scard.op1,nil,scard.tg1,EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
	--draw, absorb
	local e2=aux.AddAutoSkill(c,1,EVENT_ATTACK_ANNOUNCE,nil,scard.op2,nil,scard.con1)
	e2:SetCountLimit(1)
end
scard.front_side_code=sid-1
--gain skill
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(nil),LOCATION_BATTLE,0,1,1,HINTMSG_TARGET)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) or not tc:IsFaceup() then return end
	--gain power
	aux.AddTempSkillUpdatePower(e:GetHandler(),tc,2,5000)
end
--draw, absorb
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	return tc and tc:IsControler(tp) and tc:IsBattle()
end
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local tc1=Duel.GetAttacker()
	if not tc1:IsBattle() or not tc1:IsControler(tp) then return end
	Duel.Draw(tp,1,REASON_EFFECT)
	local dc=Duel.GetDecktopGroup(tp,1):GetFirst()
	local tc2=Duel.GetFirstMatchingCard(Card.IsCode,tp,LOCATION_BATTLE,0,nil,CARD_MAJIN_BUUS_SEALED_BALL)
	if not dc or not tc2 or not Duel.SelectYesNo(tp,YESNOMSG_ABSORB) then return end
	Duel.DisableShuffleCheck()
	Duel.PlaceUnder(tc2,dc)
end
