--BT2-050 Mai, Supporter of Hope
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_MAI_FUTURE)
	aux.AddSpecialTrait(c,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_FUTURE_TRUNKS_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--free play
	aux.AddPermanentFreePlay(c,aux.ExistingCardCondition(aux.FaceupFilter(Card.IsCharacter,CHARACTER_TRUNKS_FUTURE)))
end
scard.specified_cost={COLOR_BLUE,2}
scard.combo_cost=0
