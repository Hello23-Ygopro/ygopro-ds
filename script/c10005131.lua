--BT5-111 Black Masked Saiyan, the Devastator
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_BLACK_MASKED_SAIYAN)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_DARK_DEMON_REALM_SAGA)
	aux.AddCategory(c,NAME_CATEGORY_MASKED)
	--battle card
	aux.EnableBattleAttribute(c)
	--critical
	aux.EnableCritical(c)
	--warp
	aux.AddAutoSkill(c,0,EVENT_CUSTOM+EVENT_ATTACK_END,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
--warp
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct1=Duel.GetMatchingGroupCount(aux.DropAreaFilter(Card.IsSpecialTrait,TRAIT_SAIYAN),tp,LOCATION_DROP,0,nil)
	local ct2=Duel.GetMatchingGroupCount(aux.DropAreaFilter(Card.IsSpecialTrait,TRAIT_SAIYAN),tp,0,LOCATION_DROP,nil)
	return Duel.GetTurnPlayer()==tp
		and aux.SelfLeaderCondition(Card.IsColor,COLOR_BLACK)(e,tp,eg,ep,ev,re,r,rp)
		and ct1+ct2>=15
		and c:GetDamageCount()==0
		and c:GetBattleTarget()==Duel.GetLeaderCard(1-tp)
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.LifeAreaFilter(Card.IsAbleToWarp),0,LOCATION_LIFE,0,1,HINTMSG_WARP)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SendtoWarp(tc,REASON_EFFECT)
	end
end
