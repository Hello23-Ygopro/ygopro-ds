--BT2-015 Prodigy Fusion Super Saiyan Gotenks
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_RED,2)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_GOTENKS)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_MAJIN_BUU_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--union-fusion
	aux.EnableUnionFusion(c,scard.uniffilter1,scard.uniffilter2,aux.PaySkillCost(COLOR_RED,1,1))
	--dual attack
	aux.EnableDualAttack(c)
end
--union-fusion
scard.uniffilter1=aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_SON_GOTEN)
scard.uniffilter2=aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_TRUNKS_YOUTH)
