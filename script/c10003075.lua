--BT3-068 Stouthearted Android 16
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_ANDROID_16)
	aux.AddSpecialTrait(c,TRAIT_ANDROID)
	aux.AddEra(c,ERA_ANDROID_CELL_SAGA)
	aux.AddCategory(c,NAME_CATEGORY_ANDROID)
	--battle card
	aux.EnableBattleAttribute(c)
	--super combo
	aux.EnableSuperCombo(c)
	--drop, gain skill
	aux.AddSingleAutoSkill(c,0,EVENT_CUSTOM+EVENT_COMBO,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
scard.specified_cost={COLOR_GREEN,2}
scard.combo_cost=0
--drop, gain skill
scard.con1=aux.AND(aux.SelfLeaderCondition(Card.IsColor,COLOR_GREEN),aux.LifeEqualBelowCondition(PLAYER_SELF,4))
scard.tg1=aux.TargetCardFunction(PLAYER_OPPO,aux.HandFilter(Card.IsAbleToDrop),0,LOCATION_HAND,1,1,HINTMSG_DROP)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SendtoDrop(tc,REASON_EFFECT)
	end
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	--gain combo power
	aux.AddTempSkillUpdateComboPower(c,c,1,10000)
end
