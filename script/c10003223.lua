--TB1-064 Zirloin, Maiden Attendant
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_ZIRLOIN)
	aux.AddSpecialTrait(c,TRAIT_ALIEN,TRAIT_UNIVERSE_2)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,TRAIT_CATEGORY_UNIVERSE)
	--battle card
	aux.EnableBattleAttribute(c)
	--double strike
	aux.EnableDoubleStrike(c)
	--ko
	local e1=aux.AddActivateMainSkill(c,0,scard.op1,scard.cost1,scard.tg1,EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
end
scard.specified_cost={COLOR_GREEN,2}
scard.combo_cost=1
--ko
scard.cost1=aux.SendtoHandCost(aux.LifeAreaFilter(nil),LOCATION_LIFE,0,1,1,true)
scard.con1=aux.SelfLeaderCondition(Card.IsSpecialTrait,TRAIT_UNIVERSE_2)
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(nil),0,LOCATION_BATTLE,1,1,HINTMSG_KO,scard.con1)
scard.op1=aux.TargetCardsOperation(Duel.KO,REASON_EFFECT)
