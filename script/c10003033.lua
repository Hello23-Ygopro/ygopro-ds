--BT3-031 Majin Buu, Completely Revived
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_MAJIN_BUU)
	aux.AddSpecialTrait(c,TRAIT_MAJIN)
	aux.AddEra(c,ERA_MAJIN_BUU_SAGA)
	--leader card
	aux.EnableLeaderAttribute(c)
	--absorb, draw
	local e1=aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.op1)
	e1:SetCountLimit(1)
	--untap, gain skill
	aux.AddActivateMainSkill(c,1,scard.op2,aux.SelfDropAbsorbedCost(nil,5,5,true))
end
scard.front_side_code=sid-1
--absorb, draw
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetDecktopGroup(tp,1)
	Duel.DisableShuffleCheck()
	Duel.PlaceUnder(e:GetHandler(),g)
	Duel.BreakEffect()
	Duel.Draw(tp,1,REASON_EFFECT)
end
--untap, gain skill
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.SwitchtoActive(c,REASON_EFFECT)
	--gain power
	aux.AddTempSkillUpdatePower(c,c,2,5000)
end
