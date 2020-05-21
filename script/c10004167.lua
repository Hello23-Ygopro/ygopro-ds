--EX03-14 Last One Standing Son Goku
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_SON_GOKU)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_UNIVERSE_7)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOKU,TRAIT_CATEGORY_UNIVERSE)
	--battle card
	aux.EnableBattleAttribute(c)
	--ko
	local e1=aux.AddActivateMainSkill(c,0,scard.op1,nil,scard.tg1,EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
	--gain skill
	aux.AddSingleAutoSkill(c,1,EVENT_PLAY,nil,scard.op2,nil,scard.con1)
end
scard.specified_cost={COLOR_GREEN,2}
scard.combo_cost=1
--ko
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(nil),0,LOCATION_BATTLE,1,1,HINTMSG_KO)
scard.op1=aux.TargetCardsOperation(Duel.KO,REASON_EFFECT)
--gain skill
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_HAND)
		and Duel.IsExistingMatchingCard(aux.DropAreaFilter(Card.IsSpecialTrait,TRAIT_UNIVERSE_7),tp,LOCATION_DROP,0,9,nil)
end
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	--gain power
	aux.AddTempSkillUpdatePower(c,c,2,10000)
	--triple strike
	aux.AddTempSkillCustom(c,c,3,EFFECT_TRIPLE_STRIKE)
	--cannot negate attack
	aux.AddTempSkillCustom(c,c,4,EFFECT_CANNOT_NEGATE_ATTACK)
end
