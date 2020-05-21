--BT5-007 Grandpa Gohan, to the Rescue
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_SON_GOHAN)
	aux.AddSpecialTrait(c,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_FORTUNETELLER_BABA_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOHAN)
	--battle card
	aux.EnableBattleAttribute(c)
	--search (play, gain skill)
	aux.AddActivateMainSkill(c,0,scard.op1,scard.cost1,scard.tg1,EFFECT_FLAG_CARD_TARGET)
end
scard.specified_cost={COLOR_RED,2}
scard.combo_cost=0
--search (play, gain skill)
function scard.costfilter(c,charname)
	return c:IsCharacter(charname) and c:IsAbleToDeck()
end
function scard.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local f1=aux.DropAreaFilter(scard.costfilter,CHARACTER_BANDAGES)
	local f2=aux.DropAreaFilter(scard.costfilter,CHARACTER_SPIKE)
	if chk==0 then return c:IsAbleToDeck() and c:IsCanBeEffectTarget(e)
		and Duel.IsExistingTarget(f1,tp,LOCATION_DROP,0,1,nil)
		and Duel.IsExistingTarget(f2,tp,LOCATION_DROP,0,1,nil) end
	local g1=Group.FromCards(c)
	Duel.SetTargetCard(g1)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g2=Duel.SelectTarget(tp,f1,tp,LOCATION_DROP,0,1,1,nil)
	g1:Merge(g2)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g3=Duel.SelectTarget(tp,f2,tp,LOCATION_DROP,0,1,1,nil)
	g1:Merge(g3)
	local ct=Duel.SendtoDeck(g1,PLAYER_OWNER,SEQ_DECK_TOP,REASON_COST)
	aux.SortDeck(tp,tp,ct,SEQ_DECK_BOTTOM)
	Duel.ClearTargetCard()
end
function scard.playfilter(c,e,tp)
	return c:IsCode(CARD_GRANDPA_GOHAN) and c:IsCanBePlayed(e,0,tp,false,false) and c:IsCanBeEffectTarget(e)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	local g1=Duel.GetMatchingGroup(scard.playfilter,tp,LOCATION_DECK,0,nil,e,tp)
	local g2=Duel.GetMatchingGroup(aux.DropAreaFilter(scard.playfilter),tp,LOCATION_DROP,0,nil,e,tp)
	g1:Merge(g2)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_PLAY)
	local sg=g1:Select(tp,0,1,nil)
	Duel.SetTargetCard(sg)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e)
		or not Duel.PlayStep(tc,0,tp,tp,false,false,POS_FACEUP_ACTIVE) or not tc:IsCanBeEffectTarget(e) then return end
	Duel.BreakEffect()
	Duel.SetTargetCard(tc)
	local c=e:GetHandler()
	--gain power
	aux.AddTempSkillUpdatePower(c,tc,1,5000)
	--double strike
	aux.AddTempSkillCustom(c,tc,2,EFFECT_DOUBLE_STRIKE)
end
