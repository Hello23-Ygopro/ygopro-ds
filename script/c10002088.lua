--BT2-078 Full Power Trunks
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_TRUNKS_FUTURE)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_ANDROID_CELL_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--triple strike
	aux.EnableTripleStrike(c)
	--gain skill
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
end
scard.specified_cost={COLOR_GREEN,2}
scard.combo_cost=1
--gain skill
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(aux.BattleAreaFilter(nil),tp,0,LOCATION_BATTLE,nil)
	if g:GetCount()==0 then return end
	for tc in aux.Next(g) do
		--blocker
		aux.AddTempSkillBlocker(e:GetHandler(),tc,0,RESET_PHASE+PHASE_DAMAGE)
	end
end
