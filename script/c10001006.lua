--BT1-004 Destructive Terror Champa
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_CHAMPA)
	aux.AddSpecialTrait(c,TRAIT_GOD)
	aux.AddEra(c,ERA_CHAMPA_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--evolve
	aux.EnableEvolve(c,aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_CHAMPA),aux.PaySkillCost(COLOR_RED,3,2))
	--triple strike
	aux.EnableTripleStrike(c)
	--ko
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
scard.specified_cost={COLOR_RED,2}
scard.combo_cost=1
--ko
function scard.kofilter(c,e)
	return c:IsPowerBelow(15000) and c:IsCanBeEffectTarget(e)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	local g=Duel.GetMatchingGroup(aux.BattleAreaFilter(scard.kofilter),tp,0,LOCATION_BATTLE,nil,e)
	Duel.SetTargetCard(g)
end
scard.op1=aux.TargetCardsOperation(Duel.KO,REASON_EFFECT)
