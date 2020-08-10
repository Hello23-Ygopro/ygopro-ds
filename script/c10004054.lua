--BT4-048 Newfound Power Son Gohan
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_SON_GOHAN_YOUTH)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_FRIEZA_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOHAN)
	--battle card
	aux.EnableBattleAttribute(c)
	--to hand, gain skill
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--to hand, gain skill
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.LifeAreaFilter(Card.IsAbleToHand),LOCATION_LIFE,0,0,1,HINTMSG_ATOHAND)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) or Duel.SendtoHand(tc,PLAYER_OWNER,REASON_EFFECT)==0 then return end
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	--gain power
	aux.AddTempSkillUpdatePower(c,c,1,10000)
	--critical
	aux.AddTempSkillCritical(c,c,2)
end
