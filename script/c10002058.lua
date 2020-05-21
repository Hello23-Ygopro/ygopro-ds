--BT2-052 Courageous Heart Yajirobe
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_YAJIROBE_FUTURE)
	aux.AddSpecialTrait(c,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_FUTURE_TRUNKS_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--revenge
	aux.EnableRevenge(c)
end
scard.specified_cost={COLOR_BLUE,1}
scard.combo_cost=0
