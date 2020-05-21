--EX03-29 Forced Destruction Mira
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_MIRA)
	aux.AddSpecialTrait(c,TRAIT_ANDROID)
	aux.AddEra(c,ERA_DARK_DEMON_REALM_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--xeno-evolve
	aux.EnableXenoEvolve(c,aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_MIRA),aux.PaySkillCost(COLOR_COLORLESS,0,5))
	--triple strike
	aux.EnableTripleStrike(c)
	--warp
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_CHOOSE,scard.con1)
end
scard.combo_cost=0
--warp
function scard.lfilter(c)
	return c:IsCharacter(CHARACTER_TOWA) or c:IsSpecialTrait(TRAIT_ANDROID)
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return aux.EvolvePlayCondition(e,tp,eg,ep,ev,re,r,rp)
		and aux.SelfLeaderCondition(scard.lfilter)(e,tp,eg,ep,ev,re,r,rp)
		and Duel.IsExistingMatchingCard(Card.IsColor,tp,LOCATION_WARP,0,10,nil,COLOR_BLACK)
end
scard.tg1=aux.TargetCardFunction(PLAYER_OPPO,aux.HandFilter(Card.IsAbleToWarp),0,LOCATION_HAND,3,3,HINTMSG_WARP)
scard.op1=aux.TargetCardsOperation(Duel.SendtoWarp,REASON_EFFECT)
