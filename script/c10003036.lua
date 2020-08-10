--BT3-033 Ultra Instinct -Sign- Son Goku
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,3)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_SON_GOKU)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOKU)
	--battle card
	aux.EnableBattleAttribute(c)
	--ex-evolve
	aux.EnableEXEvolve(c,scard.evofilter,aux.MergeCost(aux.PaySkillCost(COLOR_BLUE,2,0),aux.DropCost(aux.HandFilter(nil),LOCATION_HAND,0,1)))
	--triple strike
	aux.EnableTripleStrike(c)
	--cannot combo
	aux.AddPermanentPlayerSkill(c,EFFECT_CANNOT_COMBO,LOCATION_BATTLE,aux.SelfBattlingCondition,0,1)
	--return
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,nil,scard.op1,nil,aux.EvolvePlayCondition)
end
--ex-evolve
function scard.evofilter(c)
	return c:IsColor(COLOR_BLUE) and c:IsCharacter(CHARACTER_SON_GOKU) and c:IsEnergyAbove(5)
end
--return
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(aux.BattleAreaFilter(nil),tp,0,LOCATION_BATTLE,nil)
	Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
end
