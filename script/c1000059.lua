--P-051 King Piccolo, Demon Lord
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_KING_PICCOLO)
	aux.AddSpecialTrait(c,TRAIT_NAMEKIAN)
	aux.AddEra(c,ERA_KING_PICCOLO_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--bond (gain skill)
	aux.EnableBond(c)
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,aux.BondCondition(2))
end
--bond (gain skill)
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	local f=aux.BattleAreaFilter(nil)
	if chkc then return chkc:IsLocation(LOCATION_BATTLE) and chkc:IsControler(tp) and f(chkc) and chkc~=c end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,f,tp,LOCATION_BATTLE,0,1,1,c)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		--gain power
		aux.AddTempSkillUpdatePower(c,tc,1,5000)
	end
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		--gain power
		aux.AddTempSkillUpdatePower(c,c,1,5000)
	end
end
