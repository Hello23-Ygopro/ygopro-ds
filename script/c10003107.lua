--BT3-097 Unwavering Solidarity Tora
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_TORA)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_BARDOCK_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--free play
	aux.AddPermanentFreePlay(c,aux.ExistingCardCondition(aux.BattleAreaFilter(Card.IsRest),0,LOCATION_BATTLE,2))
end
scard.specified_cost={COLOR_YELLOW,1}
scard.combo_cost=0
