--P-013 Hit, Conqueror of Time
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_RED,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_HIT)
	aux.AddSpecialTrait(c,TRAIT_ALIEN)
	aux.AddEra(c,ERA_CHAMPA_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--drop, gain skill
	aux.AddAutoSkill(c,0,EVENT_CUSTOM+EVENT_MAIN_PHASE_START,nil,scard.op1,nil,aux.TurnPlayerCondition(PLAYER_OPPO))
end
--drop, gain skill
function scard.dropfilter(c)
	return c:IsColor(COLOR_RED) and c:IsAbleToDrop()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DROP)
	local g=Duel.SelectMatchingCard(tp,aux.HandFilter(scard.dropfilter),tp,LOCATION_HAND,0,0,1,nil)
	if g:GetCount()==0 or Duel.SendtoDrop(g,REASON_EFFECT)==0 then return end
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	--cannot be ko-ed
	aux.AddTempSkillCannotBeKOed(c,c,1,EFFECT_CANNOT_BE_KOED_BATTLE)
	aux.AddTempSkillCannotBeKOed(c,c,2,EFFECT_CANNOT_BE_KOED_EFFECT,aux.indoval)
	--cannot leave
	aux.AddTempSkillCannotLeave(c,c,3)
end
