--BT1-073 Broly, The Rampaging Horror
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_BROLY)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_BROLY_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--evolve
	aux.EnableEvolve(c,aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_BROLY),aux.PaySkillCost(COLOR_GREEN,4,1))
	--double strike
	aux.EnableDoubleStrike(c)
	--drop
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
scard.specified_cost={COLOR_GREEN,4}
scard.combo_cost=1
--drop
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	local g=Duel.GetMatchingGroup(aux.HandFilter(Card.IsCanBeEffectTarget),tp,0,LOCATION_HAND,nil,e)
	local sg=g:RandomSelect(tp,0,2)
	Duel.SetTargetCard(sg)
end
scard.op1=aux.TargetCardsOperation(Duel.SendtoDrop,REASON_EFFECT)
