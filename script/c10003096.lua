--BT3-087 Gine, Family of Justice
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_GINE)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_DRAGON_BALL_MINUS_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--free play
	aux.AddPermanentFreePlay(c,aux.ExistingCardCondition(aux.FaceupFilter(Card.IsCharacter,CHARACTER_BARDOCK)))
end
