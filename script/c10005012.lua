--BT5-010 Yamcha
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_YAMCHA)
	aux.AddSpecialTrait(c,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_PILAF_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
end
scard.specified_cost={COLOR_RED,2}
scard.combo_cost=0
scard.card_code=CARD_YAMCHA
