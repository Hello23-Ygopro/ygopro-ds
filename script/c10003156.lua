--TB1-004 Universe 7 Saiyan Prince Vegeta
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_VEGETA)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_UNIVERSE_7)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,TRAIT_CATEGORY_UNIVERSE)
	--battle card
	aux.EnableBattleAttribute(c)
	--untap, gain skill
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
scard.specified_cost={COLOR_RED,2}
scard.combo_cost=1
--untap, gain skill
scard.con1=aux.AND(aux.SelfLeaderCondition(Card.IsColor,COLOR_RED),aux.SelfPreviousLocationCondition(LOCATION_HAND))
function scard.untfilter(c)
	return c:IsSpecialTrait(TRAIT_SAIYAN) and c:IsSpecialTrait(TRAIT_UNIVERSE_6,TRAIT_UNIVERSE_7)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	local f=aux.BattleAreaFilter(scard.untfilter)
	if chkc then return chkc:IsLocation(LOCATION_BATTLE) and chkc:IsControler(tp) and f(chkc) and chkc~=c end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,f,tp,LOCATION_BATTLE,0,0,1,c)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SwitchtoActive(tc,REASON_EFFECT)
		--gain power
		aux.AddTempSkillUpdatePower(c,tc,1,10000)
		--triple strike
		aux.AddTempSkillCustom(c,tc,2,EFFECT_TRIPLE_STRIKE)
	end
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		--gain power
		aux.AddTempSkillUpdatePower(c,c,1,10000)
		--triple strike
		aux.AddTempSkillCustom(c,c,2,EFFECT_TRIPLE_STRIKE)
	end
end
