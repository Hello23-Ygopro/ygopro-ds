--BT5-055 Twin Onslaught SS4 Son Goku
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_SON_GOKU_GT)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_SUPER_17_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_GT,CHAR_CATEGORY_SON_GOKU)
	--battle card
	aux.EnableBattleAttribute(c)
	--double strike
	aux.EnableDoubleStrike(c)
	--deflect
	aux.EnableDeflect(c)
	--burst (ko, gain skill)
	aux.EnableBurst(c)
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1,aux.BurstCost(5))
end
scard.specified_cost={COLOR_GREEN,3}
scard.combo_cost=1
--burst (ko, gain skill)
function scard.lfilter(c)
	return c:IsColor(COLOR_GREEN) and c:IsSpecialTrait(TRAIT_SHENRON)
end
scard.con1=aux.SelfLeaderCondition(scard.lfilter)
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	local g=Duel.GetMatchingGroup(aux.BattleAreaFilter(Card.IsCanBeEffectTarget),tp,0,LOCATION_BATTLE,nil,e)
	Duel.SetTargetCard(g)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if g1 then
		local sg1=g1:Filter(Card.IsRelateToEffect,nil,e)
		Duel.KO(sg1,REASON_EFFECT)
	end
	local g2=Duel.GetMatchingGroup(aux.BattleAreaFilter(nil),tp,0,LOCATION_BATTLE,nil)
	if g2:GetCount()==0 then return end
	e:SetProperty(e:GetProperty()+EFFECT_FLAG_IGNORE_BARRIER)
	local sg2=g2:Filter(Card.IsCanBeEffectTarget,nil,e)
	Duel.SetTargetCard(sg2)
	local c=e:GetHandler()
	for tc in aux.Next(sg2) do
		--negate skill
		aux.AddTempSkillNegateSkill(c,tc,1)
	end
	--dual attack
	aux.AddTempSkillDualAttack(c,c,2)
end
