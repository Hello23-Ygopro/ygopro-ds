--TB1-010 Impeccable Super Saiyan Cabba
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_RED,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_CABBA)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_ALIEN,TRAIT_UNIVERSE_6)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,TRAIT_CATEGORY_UNIVERSE)
	--battle card
	aux.EnableBattleAttribute(c)
	--attack active
	aux.AddSinglePermanentSkill(c,EFFECT_ATTACK_ACTIVE_MODE)
	--cannot activate
	aux.AddPermanentPlayerCannotActivate(c,aux.CannotActivateKeySkillValue(CATEGORY_COUNTER),aux.SelfAttackerCondition,0,1)
	--gain skill
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.op1,nil,aux.SelfLeaderCondition(scard.lfilter))
end
--gain skill
function scard.lfilter(c)
	return c:IsColor(COLOR_RED) and c:IsSpecialTrait(TRAIT_SAIYAN)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	--gain power
	aux.AddTempSkillUpdatePower(c,c,1,5000)
end
