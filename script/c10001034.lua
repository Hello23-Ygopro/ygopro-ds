--BT1-029 Beerus, God of Destruction
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_BEERUS)
	aux.AddSpecialTrait(c,TRAIT_GOD)
	aux.AddEra(c,ERA_BATTLE_OF_GODS_SAGA)
	--leader card
	aux.EnableLeaderAttribute(c)
	--draw, ko
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.op1,EFFECT_FLAG_CARD_TARGET)
	--win
	aux.AddActivateMainSkill(c,1,scard.op2,aux.MergeCost(aux.PaySkillCost(COLOR_COLORLESS,0,16),aux.SelfSwitchtoRestCost))
end
scard.front_side_code=sid-1
--draw, ko
function scard.kofilter(c,e)
	return c:IsEnergyBelow(3) and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_KO)
	local g=Duel.SelectMatchingCard(tp,aux.BattleAreaFilter(scard.kofilter),tp,0,LOCATION_BATTLE,0,1,nil,e)
	if g:GetCount()==0 then return end
	Duel.BreakEffect()
	Duel.SetTargetCard(g)
	Duel.KO(g,REASON_EFFECT)
end
--win
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Win(tp,WIN_REASON_BEERUS)
end
