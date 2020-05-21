--BT2-094 Iron Hammer of Justice Android 16
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_ANDROID_16)
	aux.AddSpecialTrait(c,TRAIT_ANDROID)
	aux.AddEra(c,ERA_ANDROID_CELL_SAGA)
	aux.AddCategory(c,NAME_CATEGORY_ANDROID)
	--battle card
	aux.EnableBattleAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--revenge
	aux.EnableRevenge(c)
	--untap
	aux.AddSingleAutoSkill(c,0,EVENT_BATTLE_KOING,nil,aux.SelfSwitchtoActiveOperation,nil,aux.bdocon)
end
scard.specified_cost={COLOR_GREEN,2}
scard.combo_cost=0
