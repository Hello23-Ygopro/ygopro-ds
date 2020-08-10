--BT4-053 Nail, the Namekian Ace
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_NAIL)
	aux.AddSpecialTrait(c,TRAIT_NAMEKIAN)
	aux.AddEra(c,ERA_FRIEZA_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--bond (draw, gain skill)
	aux.EnableBond(c)
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.op1,nil,aux.BondCondition(2))
end
--bond (draw, gain skill)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	--gain power
	aux.AddTempSkillUpdatePower(c,c,1,5000)
end
