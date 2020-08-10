--TB1-066 Hermilla, The Sniper
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_HERMILLA)
	aux.AddSpecialTrait(c,TRAIT_ALIEN,TRAIT_UNIVERSE_2)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,TRAIT_CATEGORY_UNIVERSE)
	--battle card
	aux.EnableBattleAttribute(c)
	--ko
	local e1=aux.AddActivateMainSkill(c,0,scard.op1,nil,scard.tg1,EFFECT_FLAG_CARD_TARGET,scard.con1)
	e1:SetCountLimit(1)
end
--ko
scard.con1=aux.ExistingCardCondition(aux.BattleAreaFilter(Card.IsCharacter,CHARACTER_PRUM),LOCATION_BATTLE)
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(Card.IsEnergyBelow,5),0,LOCATION_BATTLE,1,1,HINTMSG_KO)
scard.op1=aux.TargetCardsOperation(Duel.KO,REASON_EFFECT)
