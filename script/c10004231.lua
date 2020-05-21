--TB2-033 Shocking Latent Ability
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--extra card
	aux.EnableExtraAttribute(c)
	--gain skill, draw
	aux.AddActivateBattleSkill(c,0,scard.op1,nil,nil,nil,aux.SelfLeaderCondition(Card.IsCharacter,CHARACTER_UUB))
end
scard.specified_cost={COLOR_BLUE,1}
--gain skill, draw
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	--gain power
	aux.AddTempSkillUpdatePower(e:GetHandler(),Duel.GetLeaderCard(tp),1,10000,RESET_PHASE+PHASE_DAMAGE)
	Duel.Draw(tp,1,REASON_EFFECT)
end
