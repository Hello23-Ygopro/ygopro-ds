--BT3-092 Absolute Defense Great Ape King Vegeta
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_KING_VEGETA)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_GREAT_APE)
	aux.AddEra(c,ERA_ORIGINAL)
	--battle card
	aux.EnableBattleAttribute(c)
	--evolve
	aux.EnableEvolve(c,aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_KING_VEGETA),aux.PaySkillCost(COLOR_YELLOW,2,1))
	--double strike
	aux.EnableDoubleStrike(c)
	--gain skill (barrier)
	aux.EnableBarrier(c,nil,LOCATION_BATTLE,0,scard.tg1)
	--combo cost down
	aux.AddPermanentUpdateComboCost(c,-1,LOCATION_HAND,0,aux.TargetBoolFunction(Card.IsSpecialTrait,TRAIT_SAIYAN))
end
scard.specified_cost={COLOR_YELLOW,2}
scard.combo_cost=1
--gain skill (barrier)
function scard.tg1(e,c)
	return c:IsBattle() and c:IsColor(COLOR_YELLOW) and c:IsSpecialTrait(TRAIT_SAIYAN)
end
