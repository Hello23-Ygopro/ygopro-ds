--P-040_PR Piccolo, The Strategist (Alias)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_PICCOLO)
	aux.AddSpecialTrait(c,TRAIT_NAMEKIAN,TRAIT_GOD)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--critical
	aux.EnableCritical(c)
	--barrier
	aux.EnableBarrier(c)
	--ko
	aux.AddActivateMainSkill(c,0,scard.op1,nil,scard.tg1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
scard.specified_cost={COLOR_BLUE,3}
scard.combo_cost=0
--ko
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(sid)==0
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local cost=Duel.GetEnergyCount(tp)
	local f=aux.BattleAreaFilter(Card.IsEnergyBelow,cost)
	if chkc then return chkc:IsLocation(LOCATION_BATTLE) and chkc:IsControler(1-tp) and f(chkc) end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_KO)
	Duel.SelectTarget(tp,f,tp,0,LOCATION_BATTLE,0,1,nil)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.KO(tc,REASON_EFFECT)
	end
	Duel.BreakEffect()
	--negate skill
	Duel.NegateEffect(0)
	e:GetHandler():RegisterFlagEffect(sid,RESET_EVENT+RESETS_STANDARD,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(sid,1))
end
