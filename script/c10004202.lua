--TB2-007 Tiny Rivals Trunks
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_TRUNKS_YOUTH)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_EARTHLING,TRAIT_WORLD_TOURNAMENT)
	aux.AddEra(c,ERA_THE_EVIL_WIZARD_BABIDI_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--critical
	aux.EnableCritical(c)
	--gain power
	aux.AddPermanentUpdatePower(c,5000,aux.ExistingCardCondition(aux.BattleAreaFilter(Card.IsCode,CARD_TINY_RIVALS_SON_GOTEN),LOCATION_BATTLE))
	--double strike
	aux.EnableDoubleStrike(c,aux.ExistingCardCondition(aux.BattleAreaFilter(Card.IsCode,CARD_TINY_RIVALS_SON_GOTEN),LOCATION_BATTLE))
end
scard.specified_cost={COLOR_RED,1}
scard.combo_cost=0
