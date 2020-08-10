--BT1-088 Frieza, Hellish Terror
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,2)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_FRIEZA)
	aux.AddSpecialTrait(c,TRAIT_FRIEZA_CLAN,TRAIT_FRIEZAS_ARMY)
	aux.AddEra(c,ERA_FRIEZA_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--evolve
	aux.EnableEvolve(c,aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_FRIEZA),aux.PaySkillCost(COLOR_YELLOW,2,1))
	--double strike
	aux.EnableDoubleStrike(c)
	--tap
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,aux.EvolvePlayCondition)
end
--tap
function scard.tapfilter(c,e)
	return c:IsHasEffect(EFFECT_BLOCKER) and c:IsAbleToSwitchToRest() and c:IsCanBeEffectTarget(e)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	local g=Duel.GetMatchingGroup(aux.BattleAreaFilter(scard.tapfilter),tp,0,LOCATION_BATTLE,nil,e)
	Duel.SetTargetCard(g)
end
scard.op1=aux.TargetCardsOperation(Duel.SwitchtoRest,REASON_EFFECT)
