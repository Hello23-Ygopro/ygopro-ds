--P-088 Negating Fist SSB Son Goku
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_SON_GOKU)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_RESURRECTION_F_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOKU)
	--battle card
	aux.EnableBattleAttribute(c)
	--play, negate attack
	aux.AddCounterAttackSkill(c,0,scard.op1,nil,aux.SelfPlayTarget)
	--search (play)
	aux.AddActivateMainSkill(c,1,scard.op2,scard.cost1,scard.tg1,EFFECT_FLAG_CARD_TARGET)
end
--play, negate attack
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.Play(c,0,tp,tp,false,false,POS_FACEUP_ACTIVE)
	Duel.NegateAttack()
end
--search (play)
scard.cost1=aux.MergeCost(aux.PaySkillCost(COLOR_YELLOW,3,0),aux.SelfDropCost)
function scard.playfilter1(c,e,tp)
	return c:IsBattle() and c:IsColor(COLOR_YELLOW) and c:IsSpecialTrait(TRAIT_SAIYAN)
		and c:IsHasNoSkill() and c:IsEnergyBelow(3) and c:IsCanBePlayed(e,0,tp,false,false)
end
function scard.playfilter2(c,e,tp)
	return scard.playfilter1(c,e,tp) and c:IsCanBeEffectTarget(e)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	local g1=Duel.GetMatchingGroup(scard.playfilter2,tp,LOCATION_DECK,0,nil,e,tp)
	local g2=Duel.GetMatchingGroup(aux.DropAreaFilter(scard.playfilter2),tp,LOCATION_DROP,0,nil,e,tp)
	g1:Merge(g2)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_PLAY)
	local sg=g1:Select(tp,0,1,nil)
	Duel.SetTargetCard(sg)
end
scard.op2=aux.TargetPlayOperation(POS_FACEUP_ACTIVE)
