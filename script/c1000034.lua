--P-030 Vegeta, Powerful as Ever
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_RED,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_VEGETA_GT)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_BABY_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_GT)
	--battle card
	aux.EnableBattleAttribute(c)
	--damage
	aux.AddSingleAutoSkill(c,0,EVENT_BATTLE_KOING,nil,aux.DuelOperation(Duel.Damage,PLAYER_OPPO,1,REASON_EFFECT),nil,aux.bdocon)
end
