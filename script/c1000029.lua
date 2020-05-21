--P-021 Vegito, Here to Save the Day
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_VEGITO)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_MAJIN_BUU_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--double strike
	aux.EnableDoubleStrike(c)
	--cannot play
	aux.AddSinglePermanentSkill(c,EFFECT_PLAY_CONDITION,scard.con1)
	--draw, gain skill
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.op1,nil,aux.HandEqualBelowCondition(PLAYER_SELF,4))
end
scard.specified_cost={COLOR_RED,2}
scard.combo_cost=0
--cannot play
function scard.con1(e)
	local tp=e:GetHandlerPlayer()
	return not Duel.IsExistingMatchingCard(aux.DropAreaFilter(Card.IsCharacter,CHARACTER_SON_GOHAN_ADOLESCENCE),tp,LOCATION_DROP,0,1,nil)
		or not Duel.IsExistingMatchingCard(aux.DropAreaFilter(Card.IsCharacter,CHARACTER_SON_GOTEN),tp,LOCATION_DROP,0,1,nil)
		or not Duel.IsExistingMatchingCard(aux.DropAreaFilter(Card.IsCharacter,CHARACTER_TRUNKS_YOUTH),tp,LOCATION_DROP,0,1,nil)
end
--draw, gain skill
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,2,REASON_EFFECT)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	--gain power
	aux.AddTempSkillUpdatePower(c,c,1,10000)
end
