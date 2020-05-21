--BT5-091 Frieza, Back from Hell
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_FRIEZA)
	aux.AddSpecialTrait(c,TRAIT_FRIEZA_CLAN,TRAIT_FRIEZAS_ARMY)
	aux.AddEra(c,ERA_RESURRECTION_F_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--1 copy in battle area
	aux.AddPermanentOneCopyBattleArea(c)
	--gain skill
	local e1=aux.AddActivateMainSkill(c,0,scard.op1,nil,scard.tg1,EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_IGNORE_BARRIER)
	e1:SetCountLimit(1)
	--sparking (damage)
	aux.EnableSparking(c)
	local e2=aux.AddActivateMainSkill(c,1,scard.op2,nil,nil,EFFECT_FLAG_CARD_TARGET,scard.con1)
	e2:SetCountLimit(1)
end
scard.specified_cost={COLOR_YELLOW,2}
scard.combo_cost=0
--gain skill
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(Card.IsRest),0,LOCATION_BATTLE,1,1,HINTMSG_TARGET)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) then return end
	--cannot switch to active
	aux.AddTempSkillCustom(e:GetHandler(),tc,2,EFFECT_CANNOT_CHANGE_POS_E,RESET_PHASE+PHASE_DRAW+RESET_SELF_TURN,1,aux.SelfRestCondition)
end
--damage
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return aux.SparkingCondition(7)(e,tp,eg,ep,ev,re,r,rp) and Duel.GetRestCount(1-tp)>=7
end
function scard.lfilter(c)
	return c:IsColor(COLOR_YELLOW) and c:IsSpecialTrait(TRAIT_SHENRON)
end
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if aux.SelfLeaderCondition(scard.lfilter)(e,tp,eg,ep,ev,re,r,rp) and c:IsFaceup() and c:IsRest() then
		Duel.Damage(1-tp,1,REASON_EFFECT)
	end
end
