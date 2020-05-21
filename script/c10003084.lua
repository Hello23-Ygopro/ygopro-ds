--BT3-077 Evil Psyche, Zamasu
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_ZAMASU)
	aux.AddSpecialTrait(c,TRAIT_GOD)
	aux.AddEra(c,ERA_FUTURE_TRUNKS_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--indestructible
	aux.EnableIndestructible(c)
	--barrier
	aux.EnableBarrier(c)
	--cannot switch to active
	aux.AddSinglePermanentSkill(c,EFFECT_CANNOT_CHANGE_POS_E,aux.SelfRestCondition)
	--1 copy in battle area
	aux.AddPermanentOneCopyBattleArea(c)
end
scard.specified_cost={COLOR_GREEN,2}
scard.combo_cost=0
