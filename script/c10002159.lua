--EX02-05 Mira, From the Darkness
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_MIRA)
	aux.AddSpecialTrait(c,TRAIT_ANDROID)
	aux.AddEra(c,ERA_DARK_DEMON_REALM_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--over realm
	aux.EnableOverRealm(c,4)
	--gain skill
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,nil,scard.op1,nil,aux.OverRealmPlayCondition)
end
--gain skill
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	--critical
	aux.AddTempSkillCritical(c,c,1)
end
