--TB2-055 Unending Moves Tien Shinhan
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_TIEN_SHINHAN)
	aux.AddSpecialTrait(c,TRAIT_EARTHLING,TRAIT_WORLD_TOURNAMENT)
	aux.AddEra(c,ERA_WORLD_MA_TOURNAMENT_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--double strike
	aux.EnableDoubleStrike(c)
	--barrier
	aux.EnableBarrier(c)
	--draw, ko
	local e1=aux.AddActivateMainSkill(c,0,scard.op1,scard.cost1,nil,EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
end
--draw, ko
scard.cost1=aux.KOCost(aux.BattleAreaFilter(Card.IsCode,CARD_UNENDING_MOVES_YAMCHA),LOCATION_BATTLE,0,1)
function scard.kofilter(c,e)
	return c:IsRest() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,2,REASON_EFFECT)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_KO)
	local g=Duel.SelectMatchingCard(tp,aux.BattleAreaFilter(scard.kofilter),tp,0,LOCATION_BATTLE,0,1,nil,e)
	if g:GetCount()==0 then return end
	Duel.BreakEffect()
	Duel.SetTargetCard(g)
	Duel.KO(g,REASON_EFFECT)
end
