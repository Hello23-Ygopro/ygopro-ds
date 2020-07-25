--TB2-019 Uub, Unknowing Power
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_UUB)
	aux.AddSpecialTrait(c,TRAIT_EARTHLING,TRAIT_WORLD_TOURNAMENT)
	aux.AddEra(c,ERA_MAJIN_BUU_SAGA)
	--leader card
	aux.EnableLeaderAttribute(c)
	--draw
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,aux.DuelOperation(Duel.Draw,PLAYER_SELF,1,REASON_EFFECT))
	--return, gain skill
	aux.AddActivateMainSkill(c,1,scard.op1,scard.cost1,scard.tg1,EFFECT_FLAG_CARD_TARGET)
end
scard.front_side_code=sid-1
--return, gain skill
scard.cost1=aux.SendtoHandCost(aux.LifeAreaFilter(nil),LOCATION_LIFE,0,1)
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(Card.IsAbleToHand),0,LOCATION_BATTLE,0,1,HINTMSG_RTOHAND)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,PLAYER_OWNER,REASON_EFFECT)
	end
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	--gain power
	aux.AddTempSkillUpdatePower(c,c,2,5000)
end
