--BT2-042 Trunks, The Constant Hope
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,2)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_TRUNKS_FUTURE)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_FUTURE_TRUNKS_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--evolve
	aux.EnableEvolve(c,aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_TRUNKS_FUTURE),aux.PaySkillCost(COLOR_BLUE,2,3))
	--triple strike
	aux.EnableTripleStrike(c,scard.con1)
	--combo
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
	aux.AddSingleAutoSkill(c,0,EVENT_BE_BATTLE_TARGET,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--triple strike
function scard.con1(e)
	local tp=e:GetHandlerPlayer()
	return (Duel.IsExistingMatchingCard(aux.BattleAreaFilter(Card.IsCharacter,CHARACTER_SON_GOKU),tp,LOCATION_BATTLE,0,1,nil)
		and Duel.IsExistingMatchingCard(aux.BattleAreaFilter(Card.IsCharacter,CHARACTER_VEGETA),tp,LOCATION_BATTLE,0,1,nil))
		or (Duel.IsExistingMatchingCard(aux.DropAreaFilter(Card.IsCharacter,CHARACTER_SON_GOKU),tp,LOCATION_DROP,0,1,nil)
		and Duel.IsExistingMatchingCard(aux.DropAreaFilter(Card.IsCharacter,CHARACTER_VEGETA),tp,LOCATION_DROP,0,1,nil))
end
--combo
function scard.tcfilter(c,tp)
	return c:IsBattle() and c:IsColor(COLOR_BLUE) and c:IsCanCombo(tp)
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.DropAreaFilter(scard.tcfilter),LOCATION_DROP,0,0,1,HINTMSG_COMBO)
scard.op1=aux.TargetSendtoComboOperation
