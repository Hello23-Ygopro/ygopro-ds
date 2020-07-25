--TB1-085 Hero Combination Kunshi
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_KUNSHI)
	aux.AddSpecialTrait(c,TRAIT_ALIEN,TRAIT_PRIDE_TROOPERS,TRAIT_UNIVERSE_11)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,TRAIT_CATEGORY_UNIVERSE)
	--battle card
	aux.EnableBattleAttribute(c)
	--tap
	local e1=aux.AddActivateMainSkill(c,0,scard.op1,scard.cost1,scard.tg1,EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
end
scard.specified_cost={COLOR_YELLOW,1}
scard.combo_cost=0
--tap
scard.cost1=aux.SendtoHandCost(aux.LifeAreaFilter(nil),LOCATION_LIFE,0,1)
function scard.tapfilter(c)
	return c:IsEnergyBelow(4) and c:IsAbleToSwitchToRest()
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(aux.BattleAreaFilter(Card.IsSpecialTrait,TRAIT_UNIVERSE_11),tp,LOCATION_BATTLE,0,1,e:GetHandler())
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(scard.tapfilter),0,LOCATION_BATTLE,1,1,HINTMSG_TOREST,scard.con1)
scard.op1=aux.TargetCardsOperation(Duel.SwitchtoRest,REASON_EFFECT)
