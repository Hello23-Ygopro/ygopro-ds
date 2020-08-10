--BT4-051 Reign of Terror King Piccolo
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,2)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_KING_PICCOLO)
	aux.AddSpecialTrait(c,TRAIT_NAMEKIAN)
	aux.AddEra(c,ERA_KING_PICCOLO_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--dual attack
	aux.EnableDualAttack(c)
	--untap, play
	aux.AddActivateMainSkill(c,0,scard.op1,aux.SelfDropCost,scard.tg1,EFFECT_FLAG_CARD_TARGET)
end
--untap, play
function scard.playfilter(c,e,tp)
	return c:IsCharacter(CHARACTER_PICCOLO,CHARACTER_PICCOLO_JR) and c:IsEnergyBelow(4)
		and c:IsCanBePlayed(e,0,tp,false,false) and c:IsCanBeEffectTarget(e)
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.EnergyAreaFilter(Card.IsAbleToSwitchToActive),LOCATION_ENERGY,0,0,1,HINTMSG_TOACTIVE)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SwitchtoActive(tc,REASON_EFFECT)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_PLAY)
	local g=Duel.SelectMatchingCard(tp,aux.HandFilter(scard.playfilter),tp,LOCATION_HAND,0,0,1,nil,e,tp)
	if g:GetCount()==0 then return end
	Duel.BreakEffect()
	Duel.SetTargetCard(g)
	Duel.Play(g,0,tp,tp,false,false,POS_FACEUP_ACTIVE)
end
