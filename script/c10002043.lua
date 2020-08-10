--BT2-037 Determined Striker SSB Son Goku
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,1)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_SON_GOKU)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_FUTURE_TRUNKS_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOKU)
	--battle card
	aux.EnableBattleAttribute(c)
	--play, negate attack
	aux.AddCounterAttackSkill(c,0,scard.op1,scard.cost1,aux.SelfPlayTarget)
end
--play, negate attack
function scard.dropfilter(c)
	return c:IsSpecialTrait(TRAIT_SAIYAN) and c:IsAbleToDrop()
end
function scard.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return true end
	if Duel.GetLifeCount(tp)<=3 and Duel.IsExistingMatchingCard(aux.HandFilter(scard.dropfilter),tp,LOCATION_HAND,0,2,c)
		and Duel.SelectYesNo(tp,aux.Stringid(sid,2)) then
		Duel.Hint(HINT_OPSELECTED,1-tp,aux.Stringid(sid,1))
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DROP)
		local g=Duel.SelectMatchingCard(tp,aux.HandFilter(scard.dropfilter),tp,LOCATION_HAND,0,2,2,c)
		if Duel.SendtoDrop(g,REASON_EFFECT)>0 then
			--reduce energy cost
			aux.AddTempSkillUpdateEnergyCost(c,c,3,-3)
		end
	end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.Play(c,0,tp,tp,false,false,POS_FACEUP_ACTIVE)
	Duel.NegateAttack()
end
