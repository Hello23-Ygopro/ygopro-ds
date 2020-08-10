--BT2-084_SPR Perfect Force Cell (Alias)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,2)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_CELL)
	aux.AddSpecialTrait(c,TRAIT_ANDROID)
	aux.AddEra(c,ERA_ANDROID_CELL_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--evolve
	aux.EnableEvolve(c,aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_CELL),aux.PaySkillCost(COLOR_GREEN,2,4))
	--double strike
	aux.EnableDoubleStrike(c)
	--drop
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,aux.SelfLeaderCondition(Card.IsSpecialTrait,TRAIT_ANDROID))
end
--drop
function scard.dropfilter(c,e)
	return c:IsAbleToDrop() and c:IsCanBeEffectTarget(e)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	local ct=Duel.GetMatchingGroupCount(aux.HandFilter(scard.dropfilter),tp,0,LOCATION_HAND,nil,e)
	if ct<=3 then return end
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_DROP)
	Duel.SelectTarget(1-tp,aux.HandFilter(Card.IsAbleToDrop),1-tp,LOCATION_HAND,0,ct-3,ct-3,nil)
end
scard.op1=aux.TargetCardsOperation(Duel.SendtoDrop,REASON_EFFECT)
