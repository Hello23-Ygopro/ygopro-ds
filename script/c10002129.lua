--BT2-114 Guide Robo, Usher of Death
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_GUIDE_ROBO)
	aux.AddSpecialTrait(c,TRAIT_ROBOT)
	aux.AddEra(c,ERA_META_COOLER_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--free play
	aux.AddPermanentFreePlay(c,aux.ExistingCardCondition(aux.FaceupFilter(Card.IsCode,CARD_BIG_GETE_STAR),LOCATION_BATTLE))
end
scard.specified_cost={COLOR_YELLOW,2}
scard.combo_cost=0
