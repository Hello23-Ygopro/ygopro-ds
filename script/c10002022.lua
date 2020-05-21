--BT2-019 Foreseeing East Supreme Kai
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_EAST_SUPREME_KAI)
	aux.AddSpecialTrait(c,TRAIT_GOD)
	aux.AddEra(c,ERA_MAJIN_BUU_SAGA)
	aux.AddCategory(c,NAME_CATEGORY_SUPREME_KAI)
	--battle card
	aux.EnableBattleAttribute(c)
	--blocker
	aux.EnableBlocker(c)
end
scard.specified_cost={COLOR_RED,1}
scard.combo_cost=0
