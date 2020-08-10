--BT4-093 Explorer Bulma
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_BULMA)
	aux.AddSpecialTrait(c,TRAIT_SPECIAL_MODEL_KIT)
	aux.AddEra(c,ERA_SPECIAL)
	--battle card
	aux.EnableBattleAttribute(c)
	--drop, untap, draw
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,nil,scard.op1)
end
--drop, untap, draw
function scard.untfilter(c,e)
	return c:IsAbleToSwitchToActive() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendDecktoptoDropUpTo(tp,2,REASON_EFFECT)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOACTIVE)
	local g=Duel.SelectMatchingCard(tp,aux.EnergyAreaFilter(scard.untfilter),tp,LOCATION_ENERGY,0,0,2,nil,e)
	if g:GetCount()>0 then
		Duel.BreakEffect()
		Duel.SetTargetCard(g)
		Duel.SwitchtoActive(g,REASON_EFFECT)
	end
	Duel.Draw(tp,1,REASON_EFFECT)
end
