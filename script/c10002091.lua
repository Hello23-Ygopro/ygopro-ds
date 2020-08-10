--BT2-081 Destined Deed Krillin
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_KRILLIN)
	aux.AddSpecialTrait(c,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_ANDROID_CELL_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--free play
	aux.AddPermanentFreePlay(c,aux.ExistingCardCondition(aux.FaceupFilter(Card.IsCharacter,CHARACTER_ANDROID_18)))
end
