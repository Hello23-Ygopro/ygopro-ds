--BT3-100 Unwavering Solidarity Shugesh
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_SHUGESH)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_BARDOCK_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--super combo
	aux.EnableSuperCombo(c)
	--play, gain skill
	aux.AddSingleAutoSkill(c,0,EVENT_CUSTOM+EVENT_COMBO,nil,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
scard.specified_cost={COLOR_YELLOW,1}
scard.combo_cost=0
--play, gain skill
scard.con1=aux.AND(aux.SelfLeaderCondition(Card.IsColor,COLOR_YELLOW),aux.LifeEqualBelowCondition(PLAYER_SELF,4))
function scard.playfilter(c,e,tp)
	return c:IsSpecialTrait(TRAIT_SAIYAN) and c:IsEnergyBelow(3)
		and c:IsCanBePlayed(e,0,tp,false,false) and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	--combo gain power
	aux.AddTempSkillUpdateComboPower(c,c,1,10000)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_PLAY)
	local g=Duel.SelectMatchingCard(tp,aux.HandFilter(scard.playfilter),tp,LOCATION_HAND,0,0,1,nil,e,tp)
	if g:GetCount()==0 then return end
	Duel.BreakEffect()
	Duel.SetTargetCard(g)
	Duel.Play(g,0,tp,tp,false,false,POS_FACEUP_ACTIVE)
end
