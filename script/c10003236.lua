--TB1-075 Full Power Spirit Bomb Son Goku
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_SON_GOKU)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_UNIVERSE_7)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOKU,TRAIT_CATEGORY_UNIVERSE)
	--battle card
	aux.EnableBattleAttribute(c)
	--double strike
	aux.EnableDoubleStrike(c)
	--draw, untap
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,nil,scard.op1,EFFECT_FLAG_CARD_TARGET)
	--gain skill
	aux.AddActivateMainSkill(c,1,scard.op2,scard.cost1,nil,EFFECT_FLAG_CARD_TARGET)
end
scard.specified_cost={COLOR_YELLOW,2}
scard.combo_cost=1
--draw, untap
function scard.untfilter(c,e)
	return c:IsAbleToSwitchToActive() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOACTIVE)
	local g=Duel.SelectMatchingCard(tp,aux.EnergyAreaFilter(scard.untfilter),tp,LOCATION_ENERGY,0,0,1,nil,e)
	if g:GetCount()==0 then return end
	Duel.BreakEffect()
	Duel.SetTargetCard(g)
	Duel.SwitchtoActive(g,REASON_EFFECT)
end
--gain skill
scard.cost1=aux.SendtoHandCost(aux.LifeAreaFilter(nil),LOCATION_LIFE,0,2)
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	--gain power
	aux.AddTempSkillUpdatePower(c,c,2,10000)
end
