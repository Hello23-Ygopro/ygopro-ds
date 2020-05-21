--BT5-026 Son Gohan
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_SON_GOHAN_ADOLESCENCE)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_EARTHLING,TRAIT_SHENRON)
	aux.AddEra(c,ERA_JANEMBA_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOHAN)
	--leader card
	aux.EnableLeaderAttribute(c)
	--gain skill, to hand
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.op1,EFFECT_FLAG_CARD_TARGET)
	--wish
	aux.EnableWish(c)
end
scard.back_side_code=sid+1
--gain skill, to hand
function scard.thfilter(c,e)
	return c:IsHasEffect(EFFECT_DRAGON_BALL) and c:IsAbleToHand() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		--gain power
		aux.AddTempSkillUpdatePower(c,c,1,5000)
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
