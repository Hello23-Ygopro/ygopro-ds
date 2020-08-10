--BT3-004 Rising Fist Super Saiyan 2 Son Goku
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_RED,3)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_SON_GOKU_GT)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_BLACK_STAR_DRAGON_BALL_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_GT,CHAR_CATEGORY_SON_GOKU)
	--battle card
	aux.EnableBattleAttribute(c)
	--evolve
	aux.EnableEvolve(c,aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_SON_GOKU_GT),aux.PaySkillCost(COLOR_RED,3,1))
	--double strike
	aux.EnableDoubleStrike(c)
	--draw
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,nil,aux.DuelOperation(Duel.Draw,PLAYER_SELF,2,REASON_EFFECT),nil,aux.EvolvePlayCondition)
end
