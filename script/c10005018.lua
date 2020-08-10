--BT5-016 Pilaf, Leader of the Crew
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_RED,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_PILAF)
	aux.AddSpecialTrait(c,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_FORTUNETELLER_BABA_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--search (play)
	aux.AddActivateMainSkill(c,0,scard.op1,scard.cost1,scard.tg1,EFFECT_FLAG_CARD_TARGET)
	--gain skill
	local e1=aux.AddActivateMainSkill(c,1,scard.op2,scard.cost2,scard.tg2,EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
end
--search (play)
function scard.costfilter1(c,code)
	return c:IsCode(code) and c:IsAbleToDrop()
end
function scard.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local f=aux.BattleAreaFilter(scard.costfilter1)
	if chk==0 then return c:IsAbleToDrop() and c:IsCanBeEffectTarget(e)
		and Duel.IsExistingTarget(f,tp,LOCATION_BATTLE,0,1,nil,CARD_SHU_TRUSTED_LACKEY)
		and Duel.IsExistingTarget(f,tp,LOCATION_BATTLE,0,1,nil,CARD_MAI_TRUSTED_LACKEY) end
	local g1=Group.FromCards(c)
	Duel.SetTargetCard(g1)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DROP)
	local g2=Duel.SelectTarget(tp,f,tp,LOCATION_BATTLE,0,1,1,nil,CARD_SHU_TRUSTED_LACKEY)
	g1:Merge(g2)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DROP)
	local g3=Duel.SelectTarget(tp,f,tp,LOCATION_BATTLE,0,1,1,nil,CARD_MAI_TRUSTED_LACKEY)
	g1:Merge(g3)
	Duel.SendtoDrop(g1,REASON_COST)
	Duel.ClearTargetCard()
end
function scard.playfilter(c,e,tp)
	return c:IsCode(CARD_COMBINER_MECHA_PILAF_MACHINE)
		and c:IsCanBePlayed(e,0,tp,false,false) and c:IsCanBeEffectTarget(e)
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
scard.op1=aux.TargetPlayOperation(POS_FACEUP_ACTIVE)
--gain skill
function scard.costfilter2(c)
	return c:IsHasEffect(EFFECT_DRAGON_BALL) and c:IsAbleToDrop()
end
function scard.cost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DROP)
	local g=Duel.SelectTarget(tp,scard.costfilter2,tp,LOCATION_DECK,0,0,1,nil)
	if Duel.SendtoDrop(g,REASON_COST)==0 then return end
	e:SetLabel(1)
	Duel.ClearTargetCard()
end
function scard.tg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	if e:GetLabel()==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,aux.BattleAreaFilter(Card.IsCode,CARD_SHU_TRUSTED_LACKEY),tp,LOCATION_BATTLE,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,aux.BattleAreaFilter(Card.IsCode,CARD_MAI_TRUSTED_LACKEY),tp,LOCATION_BATTLE,0,1,1,nil)
end
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if not g then return end
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	for tc in aux.Next(sg) do
		--gain power
		aux.AddTempSkillUpdatePower(e:GetHandler(),tc,2,5000)
	end
end
