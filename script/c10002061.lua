--BT2-055 Warrior of the Gods Goku Black
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_GOKU_BLACK)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_GOD)
	aux.AddEra(c,ERA_FUTURE_TRUNKS_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--cannot be ko-ed
	aux.AddPermanentCannotBeKOed(c,EFFECT_CANNOT_BE_KOED_EFFECT,aux.indoval,scard.con1)
	--cannot leave
	aux.AddPermanentCannotLeave(c,scard.con1)
end
scard.specified_cost={COLOR_BLUE,1}
scard.combo_cost=0
--cannot be ko-ed, cannot leave
scard.con1=aux.ExistingCardCondition(aux.BattleAreaFilter(Card.IsCharacter,CHARACTER_ZAMASU),LOCATION_BATTLE)
