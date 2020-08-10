--BT4-060 Lord Slug, Young Again
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_LORD_SLUG)
	aux.AddSpecialTrait(c,TRAIT_NAMEKIAN,TRAIT_SLUGS_ARMY)
	aux.AddEra(c,ERA_LORD_SLUG_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--bond (play, untap)
	aux.EnableBond(c)
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
--bond (play, untap)
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return aux.BondCondition(2,Card.IsSpecialTrait,TRAIT_SLUGS_ARMY)(e,tp,eg,ep,ev,re,r,rp)
		and aux.SelfLeaderCondition(Card.IsSpecialTrait,TRAIT_SLUGS_ARMY)(e,tp,eg,ep,ev,re,r,rp)
end
function scard.playfilter(c,e,tp)
	return c:IsSpecialTrait(TRAIT_SLUGS_ARMY) and c:IsEnergyBelow(3) and c:IsCanBePlayed(e,0,tp,false,false)
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.DropAreaFilter(scard.playfilter),LOCATION_DROP,0,0,1,HINTMSG_PLAY)
function scard.untfilter(c,e)
	return c:IsAbleToSwitchToActive() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.Play(tc,0,tp,tp,false,false,POS_FACEUP_ACTIVE)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOACTIVE)
	local g=Duel.SelectMatchingCard(tp,aux.EnergyAreaFilter(scard.untfilter),tp,LOCATION_ENERGY,0,0,1,nil,e)
	if g:GetCount()==0 then return end
	Duel.BreakEffect()
	Duel.SetTargetCard(g)
	Duel.SwitchtoActive(g,REASON_EFFECT)
end
