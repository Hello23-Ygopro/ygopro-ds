--BT2-082 Yamcha
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_YAMCHA)
	aux.AddSpecialTrait(c,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_ANDROID_CELL_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
end
scard.specified_cost={COLOR_GREEN,1}
scard.combo_cost=0
scard.card_code=CARD_YAMCHA
