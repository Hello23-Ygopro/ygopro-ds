--BT2-085 Evolving Evil Lifeform Cell
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_CELL)
	aux.AddSpecialTrait(c,TRAIT_ANDROID)
	aux.AddEra(c,ERA_ANDROID_CELL_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--union-absorb
	aux.EnableUnionAbsorb(c,aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_CELL),scard.cost1)
	--double strike
	aux.EnableDoubleStrike(c)
	--draw, ko
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,nil,scard.op1,EFFECT_FLAG_CARD_TARGET,aux.UnionPlayCondition)
end
scard.specified_cost={COLOR_GREEN,2}
scard.combo_cost=1
--union-absorb
scard.cost1=aux.AbsorbCost(aux.HandFilter(Card.IsCharacter,CHARACTER_ANDROID_18),LOCATION_HAND,0,0,1)
--draw, ko
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_KO)
	local g=Duel.SelectMatchingCard(tp,aux.BattleAreaFilter(Card.IsCanBeEffectTarget),tp,0,LOCATION_BATTLE,0,1,nil,e)
	if g:GetCount()==0 then return end
	Duel.BreakEffect()
	Duel.SetTargetCard(g)
	Duel.KO(g,REASON_EFFECT)
end
