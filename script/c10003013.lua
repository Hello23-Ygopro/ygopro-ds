--BT3-012 Dependable Robot Giru
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_RED,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_GIRU)
	aux.AddSpecialTrait(c,TRAIT_MACHINE_MUTANT)
	aux.AddEra(c,ERA_BLACK_STAR_DRAGON_BALL_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--free play
	aux.AddPermanentFreePlay(c,aux.ExistingCardCondition(aux.FaceupFilter(Card.IsCharacter,CHARACTER_PAN)))
end
