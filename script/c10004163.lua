--EX03-11 Undying Link Zamasu
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_ZAMASU)
	aux.AddSpecialTrait(c,TRAIT_GOD)
	aux.AddEra(c,ERA_FUTURE_TRUNKS_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--indestructible
	aux.EnableIndestructible(c)
	--damage, untap
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,nil,scard.op1,nil,scard.con1)
end
--damage, untap
scard.con1=aux.AND(aux.SelfLeaderCondition(Card.IsCharacter,CHARACTER_ZAMASU,CHARACTER_GOKU_BLACK),aux.EnergyEqualAboveCondition(PLAYER_SELF,5))
function scard.untfilter(c,e)
	return c:IsAbleToSwitchToActive() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.SelectYesNo(tp,YESNOMSG_DAMAGESELF) or Duel.Damage(tp,2,REASON_EFFECT)==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOACTIVE)
	local g=Duel.SelectMatchingCard(tp,aux.EnergyAreaFilter(scard.untfilter),tp,LOCATION_ENERGY,0,0,4,nil,e)
	if g:GetCount()==0 then return end
	Duel.SetTargetCard(g)
	Duel.SwitchtoActive(g,REASON_EFFECT)
end
