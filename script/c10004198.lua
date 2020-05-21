--TB2-004 Tiny Rivals Son Goten
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_SON_GOTEN)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_EARTHLING,TRAIT_WORLD_TOURNAMENT)
	aux.AddEra(c,ERA_THE_EVIL_WIZARD_BABIDI_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--barrier
	aux.EnableBarrier(c)
	--gain power
	aux.AddPermanentUpdatePower(c,5000,aux.ExistingCardCondition(aux.BattleAreaFilter(Card.IsCode,CARD_TINY_RIVALS_TRUNKS),LOCATION_BATTLE))
	--double strike
	aux.EnableDoubleStrike(c,aux.ExistingCardCondition(aux.BattleAreaFilter(Card.IsCode,CARD_TINY_RIVALS_TRUNKS),LOCATION_BATTLE))
end
scard.specified_cost={COLOR_RED,1}
scard.combo_cost=0
