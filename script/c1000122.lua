--P-085 Fortuneteller Baba, Earth's Seer
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_FORTUNETELLER_BABA)
	aux.AddSpecialTrait(c,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_FORTUNETELLER_BABA_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--gain skill
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
	--draw, gain skill
	aux.AddSingleAutoSkill(c,1,EVENT_CUSTOM+EVENT_COMBO,nil,scard.op2,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
scard.specified_cost={COLOR_RED,1}
scard.combo_cost=0
--gain skill
function scard.powfilter(c)
	return (c:IsLeader() or c:IsBattle()) and c:IsSpecialTrait(TRAIT_EARTHLING)
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.FaceupFilter(scard.powfilter),LOCATION_INPLAY,0,0,1,HINTMSG_TARGET)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) then return end
	--gain power
	aux.AddTempSkillUpdatePower(e:GetHandler(),tc,2,5000)
end
--draw, gain skill
scard.con1=aux.SelfPreviousLocationCondition(LOCATION_BATTLE)
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectMatchingCard(tp,aux.BattleAreaFilter(Card.IsCanBeEffectTarget),tp,0,LOCATION_BATTLE,0,1,nil,e)
	if g:GetCount()==0 then return end
	Duel.BreakEffect()
	Duel.SetTargetCard(g)
	--lose power
	aux.AddTempSkillUpdatePower(c,g:GetFirst(),3,-5000)
end
