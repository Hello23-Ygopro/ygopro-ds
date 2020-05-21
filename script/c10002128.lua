--BT2-113 Pivotal Defense Cyclopian Guard
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_CYCLOPIAN_GUARD)
	aux.AddSpecialTrait(c,TRAIT_ROBOT)
	aux.AddEra(c,ERA_META_COOLER_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--cannot attack
	aux.AddSinglePermanentSkill(c,EFFECT_CANNOT_ATTACK,aux.NOT(aux.ExistingCardCondition(aux.FaceupFilter(Card.IsCode,CARD_BIG_GETE_STAR),LOCATION_BATTLE)))
end
scard.specified_cost={COLOR_YELLOW,1}
scard.combo_cost=0
