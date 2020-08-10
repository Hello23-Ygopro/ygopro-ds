--BT2-088 Expanding Energy Android 17
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,2)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_ANDROID_17)
	aux.AddSpecialTrait(c,TRAIT_ANDROID)
	aux.AddEra(c,ERA_ANDROID_CELL_SAGA)
	aux.AddCategory(c,NAME_CATEGORY_ANDROID)
	--battle card
	aux.EnableBattleAttribute(c)
	--double strike
	aux.EnableDoubleStrike(c)
	--draw
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.op1)
end
--draw
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetHandCount(tp)
	if ct<4 then
		Duel.Draw(tp,4-ct,REASON_EFFECT)
	end
end
