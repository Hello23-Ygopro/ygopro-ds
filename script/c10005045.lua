--BT5-039 Quick Thinkin' Gotenks
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_GOTENKS)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_JANEMBA_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--critical
	aux.EnableCritical(c)
	--union-fusion
	aux.EnableUnionFusion(c,scard.uniffilter1,scard.uniffilter2,aux.PaySkillCost(COLOR_BLUE,2,0))
	--draw
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,nil,aux.DuelOperation(Duel.Draw,PLAYER_SELF,2,REASON_EFFECT),nil,aux.UnionPlayCondition)
	--draw
	aux.AddSingleAutoSkill(c,1,EVENT_ATTACK_ANNOUNCE,nil,aux.DuelOperation(Duel.Draw,PLAYER_SELF,1,REASON_EFFECT))
end
scard.specified_cost={COLOR_BLUE,2}
scard.combo_cost=0
--union-fusion
scard.uniffilter1=aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_SON_GOTEN)
scard.uniffilter2=aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_TRUNKS_YOUTH)
