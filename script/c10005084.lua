--BT5-070 Android 20, Vile Creator
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,1)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_ANDROID_20)
	aux.AddSpecialTrait(c,TRAIT_ANDROID)
	aux.AddEra(c,ERA_SUPER_17_SAGA)
	aux.AddCategory(c,NAME_CATEGORY_ANDROID)
	--battle card
	aux.EnableBattleAttribute(c)
	--gain skill
	aux.AddSingleAutoSkill(c,0,EVENT_CUSTOM+EVENT_COMBO,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,aux.TurnPlayerCondition(PLAYER_SELF))
end
--gain skill
function scard.skfilter(c)
	return Duel.GetAttacker()==c and c:IsColor(COLOR_GREEN) and c:IsSpecialTrait(TRAIT_ANDROID)
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.skfilter,LOCATION_INPLAY,0,0,1,HINTMSG_TARGET)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) then return end
	local c=e:GetHandler()
	--gain power
	aux.AddTempSkillUpdatePower(c,tc,1,5000)
	--double strike
	aux.AddTempSkillCustom(c,tc,2,EFFECT_DOUBLE_STRIKE)
end
