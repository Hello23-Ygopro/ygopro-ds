--BT2-023 Dabura, The Wizard's Right Hand
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_DABURA)
	aux.AddSpecialTrait(c,TRAIT_DEMON_REALM_RACE)
	aux.AddEra(c,ERA_THE_EVIL_WIZARD_BABIDI_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--attack limit
	aux.AddPermanentCannotSelectBattleTarget(c,aux.TargetBoolFunction(Card.IsCharacter,CHARACTER_EVIL_WIZARD_BABIDI),aux.SelfRestCondition,0,LOCATION_BATTLE)
end
scard.specified_cost={COLOR_RED,3}
scard.combo_cost=0
