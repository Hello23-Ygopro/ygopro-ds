--BT2-119 Cabira, The Obedient Soldier
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_CABIRA)
	aux.AddSpecialTrait(c,TRAIT_CHILLEDS_ARMY)
	aux.AddEra(c,ERA_CHILLED_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--gain skill
	local e1=aux.AddActivateBattleSkill(c,0,scard.op1,scard.cost1,scard.tg1,EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
end
--gain skill
scard.cost1=aux.SwitchtoRestCost(aux.BattleAreaFilter(Card.IsCode,CARD_BT2102_CHILLEDS_ARMY_TOKEN),LOCATION_BATTLE,0,1)
function scard.powfilter(c)
	return c:IsCharacter(CHARACTER_CHILLED) or c:IsSpecialTrait(TRAIT_CHILLEDS_ARMY)
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(scard.powfilter),LOCATION_BATTLE,0,0,1,HINTMSG_TARGET)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) then return end
	--gain power
	aux.AddTempSkillUpdatePower(e:GetHandler(),tc,1,5000,RESET_PHASE+PHASE_DAMAGE)
end
