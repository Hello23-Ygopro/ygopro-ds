--BT1-054 Encouraging Presence Monaka
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--extra card
	aux.EnableExtraAttribute(c)
	--gain skill, draw
	aux.AddActivateMainSkill(c,0,scard.op1)
end
scard.specified_cost={COLOR_BLUE,1}
--gain skill, draw
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetLeaderCard(tp)
	if tc:IsFaceup() then
		--double strike
		aux.AddTempSkillCustom(e:GetHandler(),tc,1,EFFECT_DOUBLE_STRIKE)
	end
	Duel.BreakEffect()
	Duel.Draw(tp,1,REASON_EFFECT)
end
