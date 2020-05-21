--TB2-039_SPR Destined Conclusion Piccolo Jr. (Alias)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_PICCOLO_JR)
	aux.AddSpecialTrait(c,TRAIT_NAMEKIAN,TRAIT_WORLD_TOURNAMENT)
	aux.AddEra(c,ERA_WORLD_MA_TOURNAMENT_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--critical
	aux.EnableCritical(c)
	--ko, gain skill
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
scard.specified_cost={COLOR_GREEN,2}
scard.combo_cost=1
--ko, gain skill
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_KO)
	Duel.SelectTarget(tp,aux.BattleAreaFilter(nil),tp,LOCATION_BATTLE,0,0,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_KO)
	Duel.SelectTarget(tp,aux.BattleAreaFilter(nil),tp,0,LOCATION_BATTLE,0,1,nil)
end
function scard.cfilter(c,tp)
	return c:IsCode(CARD_DESTINED_CONCLUSION_HERO) and c:GetPreviousControler()==tp
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if not g then return end
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	if Duel.KO(sg,REASON_EFFECT)==0 then return end
	if not Duel.GetOperatedGroup():IsExists(scard.cfilter,1,nil,tp) then return end
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	--gain power
	aux.AddTempSkillUpdatePower(c,c,1,10000)
	--triple strike
	aux.AddTempSkillCustom(c,c,2,EFFECT_TRIPLE_STRIKE)
end
