--P-036_PR02 Scientist Fu (Alias)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_FU)
	aux.AddSpecialTrait(c,TRAIT_SCIENTIST)
	aux.AddEra(c,ERA_UNKNOWN)
	--battle card
	aux.EnableBattleAttribute(c)
	--over realm
	aux.EnableOverRealm(c,7,aux.PaySkillCost(COLOR_COLORLESS,0,1))
	--double strike
	aux.EnableDoubleStrike(c)
	--draw
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,nil,aux.DuelOperation(Duel.Draw,PLAYER_SELF,2,REASON_EFFECT),nil,aux.OverRealmPlayCondition)
end
scard.combo_cost=1
