--BT3-071 Unfeeling Destroyer Android 14
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,2)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_ANDROID_14)
	aux.AddSpecialTrait(c,TRAIT_ANDROID)
	aux.AddEra(c,ERA_ANDROID_13_SAGA)
	aux.AddCategory(c,NAME_CATEGORY_ANDROID)
	--battle card
	aux.EnableBattleAttribute(c)
	--double strike
	aux.EnableDoubleStrike(c)
	--ko, draw
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--ko, draw
scard.tg1=aux.TargetCardFunction(PLAYER_OPPO,aux.BattleAreaFilter(nil),0,LOCATION_BATTLE,1,1,HINTMSG_KO)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc1=Duel.GetFirstTarget()
	if not tc1 or not tc1:IsRelateToEffect(e) or Duel.KO(tc1,REASON_EFFECT)==0 then return end
	local tc2=Duel.GetOperatedGroup():GetFirst()
	if tc2:IsEnergyBelow(3) then
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
