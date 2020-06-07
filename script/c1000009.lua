--P-009 Clan of Terror Cooler
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_COOLER)
	aux.AddSpecialTrait(c,TRAIT_FRIEZA_CLAN)
	aux.AddEra(c,ERA_COOLER_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--critical
	aux.EnableCritical(c)
	--gain power
	aux.AddPermanentUpdatePower(c,5000,aux.ExistingCardCondition(aux.DropAreaFilter(Card.IsSpecialTrait,TRAIT_FRIEZA_CLAN),LOCATION_DROP,0,7))
	--double strike
	aux.EnableDoubleStrike(c,aux.ExistingCardCondition(aux.DropAreaFilter(Card.IsSpecialTrait,TRAIT_FRIEZA_CLAN),LOCATION_DROP,0,7))
end
scard.specified_cost={COLOR_YELLOW,2}
scard.combo_cost=1
