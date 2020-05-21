--TB2-023 Pan, Proudest Daughter
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_PAN)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_EARTHLING,TRAIT_WORLD_TOURNAMENT)
	aux.AddEra(c,ERA_MAJIN_BUU_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--dual attack
	aux.EnableDualAttack(c)
	--gain power
	aux.AddPermanentUpdatePower(c,10000,scard.con1)
	--double strike
	aux.EnableDoubleStrike(c,scard.con1)
end
scard.specified_cost={COLOR_BLUE,2}
scard.combo_cost=1
--gain power, double strike
function scard.lfilter(c)
	return c:IsColor(COLOR_BLUE) and c:IsSpecialTrait(TRAIT_WORLD_TOURNAMENT)
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return aux.SelfLeaderCondition(scard.lfilter)(e,tp,eg,ep,ev,re,r,rp)
		and Duel.IsExistingMatchingCard(aux.BattleAreaFilter(Card.IsCode,CARD_HERCULE_PROUDEST_GRANDPA),e:GetHandlerPlayer(),LOCATION_BATTLE,0,1,nil)
end
