--BT3-035 Furious Rush Super Saiyan 3 Son Goku
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,2)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_SON_GOKU)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_MAJIN_BUU_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOKU)
	--battle card
	aux.EnableBattleAttribute(c)
	--double attack
	aux.EnableDualAttack(c)
	--draw
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,nil,aux.DuelOperation(Duel.Draw,PLAYER_SELF,1,REASON_EFFECT))
end
