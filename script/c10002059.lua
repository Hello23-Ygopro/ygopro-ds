--BT2-053 Tiny Heroes Haru and Maki
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_HARU,CHARACTER_MAKI)
	aux.AddSpecialTrait(c,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_FUTURE_TRUNKS_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--gain skill
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--gain skill
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
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) then return end
	--gain power
	aux.AddTempSkillUpdatePower(e:GetHandler(),tc,1,scard.val1)
end
function scard.val1(e,c)
	return Duel.GetEnergyCount(c:GetControler())*1000
end
