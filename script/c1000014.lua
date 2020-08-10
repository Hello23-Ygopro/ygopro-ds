--P-014 Bursting Energy Super Saiyan Vegito
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,3)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_VEGITO)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_MAJIN_BUU_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--union-potara
	aux.EnableUnionPotara(c,scard.unipfilter1,scard.unipfilter2,aux.PaySkillCost(COLOR_BLUE,2,2))
	--double strike
	aux.EnableDoubleStrike(c)
	--untap
	local e1=aux.AddActivateMainSkill(c,0,scard.op1,scard.cost1,scard.tg1,EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
end
--union-potara
scard.unipfilter1=aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_SON_GOKU)
scard.unipfilter2=aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_VEGETA)
--untap
scard.cost1=aux.DropCost(aux.LifeAreaFilter(nil),LOCATION_LIFE,0,1)
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.EnergyAreaFilter(Card.IsAbleToSwitchToActive),LOCATION_ENERGY,0,0,2,HINTMSG_TOACTIVE)
scard.op1=aux.TargetCardsOperation(Duel.SwitchtoActive,REASON_EFFECT)
