--TB1-076 Master Roshi, Forged of Will
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_MASTER_ROSHI)
	aux.AddSpecialTrait(c,TRAIT_EARTHLING,TRAIT_UNIVERSE_7)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,TRAIT_CATEGORY_UNIVERSE)
	--battle card
	aux.EnableBattleAttribute(c)
	--negate attack, play
	aux.AddCounterAttackSkill(c,0,scard.op1)
end
--negate attack, play
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.NegateAttack()
	Duel.Play(c,0,tp,tp,false,false,POS_FACEUP_ACTIVE)
end
