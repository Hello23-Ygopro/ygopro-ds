--BT2-107 Infinite Multiplication Meta-Cooler
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_META_COOLER)
	aux.AddSpecialTrait(c,TRAIT_FRIEZA_CLAN)
	aux.AddEra(c,ERA_META_COOLER_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--unlimited copies
	aux.AddSinglePermanentSkill(c,EFFECT_UNLIMITED_COPIES)
end
scard.specified_cost={COLOR_YELLOW,2}
scard.combo_cost=0
