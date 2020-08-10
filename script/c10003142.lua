--SD2-03 Unbreakable Super Saiyan Son Goku
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_RED,2)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_SON_GOKU_GT)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_BLACK_STAR_DRAGON_BALL_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_GT,CHAR_CATEGORY_SON_GOKU)
	--battle card
	aux.EnableBattleAttribute(c)
	--evolve
	aux.EnableEvolve(c,aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_SON_GOKU_GT),aux.PaySkillCost(COLOR_RED,2,1))
	--barrier
	aux.EnableBarrier(c)
	--draw
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,nil,aux.DuelOperation(Duel.Draw,PLAYER_SELF,1,REASON_EFFECT),nil,aux.EvolvePlayCondition)
	aux.AddSingleAutoSkill(c,0,EVENT_CUSTOM+EVENT_COMBO,nil,aux.DuelOperation(Duel.Draw,PLAYER_SELF,1,REASON_EFFECT))
end
