--P-039 Combination Attack Pan
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_PAN)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_BLACK_STAR_DRAGON_BALL_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--free play
	aux.AddPermanentFreePlay(c,aux.ExistingCardCondition(aux.BattleAreaFilter(scard.cfilter),LOCATION_BATTLE))
	--gain skill
	local e1=aux.AddActivateMainSkill(c,0,scard.op1,nil,scard.tg1,EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
end
scard.specified_cost={COLOR_RED,1}
scard.combo_cost=0
--free play
function scard.cfilter(c)
	return c:IsCharacter(CHARACTER_SON_GOKU_GT,CHARACTER_TRUNKS_GT) and c:IsPowerAbove(25000)
end
--gain skill
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(Card.IsCharacter,CHARACTER_SON_GOKU_GT,CHARACTER_TRUNKS_GT),LOCATION_BATTLE,0,0,1,HINTMSG_TARGET)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) then return end
	--gain power
	aux.AddTempSkillUpdatePower(e:GetHandler(),tc,1,5000)
end
