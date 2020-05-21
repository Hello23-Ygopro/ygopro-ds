--BT5-080 Sorbet
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_SORBET)
	aux.AddSpecialTrait(c,TRAIT_FRIEZAS_ARMY,TRAIT_SHENRON)
	aux.AddEra(c,ERA_RESURRECTION_F_SAGA)
	--leader card
	aux.EnableLeaderAttribute(c)
	--gain skill, to hand
	local e1=aux.AddAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
	e1:SetCountLimit(1)
	--wish
	aux.EnableWish(c)
end
scard.back_side_code=sid+1
--gain skill, to hand
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	return tc and tc:IsControler(tp) and tc:IsBattle()
end
function scard.thfilter(c,e)
	return c:IsHasEffect(EFFECT_DRAGON_BALL) and c:IsAbleToHand() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		--gain power
		aux.AddTempSkillUpdatePower(c,Duel.GetAttacker(),1,5000)
	end
	local g1=Duel.GetMatchingGroup(scard.thfilter,tp,LOCATION_DECK,0,nil,e)
	local g2=Duel.GetMatchingGroup(aux.LifeAreaFilter(scard.thfilter),tp,LOCATION_LIFE,0,nil,e)
	g1:Merge(g2)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local sg=g1:Select(tp,0,1,nil)
	if sg:GetCount()==0 then return end
	Duel.BreakEffect()
	Duel.SetTargetCard(sg)
	Duel.SendtoHand(sg,PLAYER_OWNER,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,sg)
end
