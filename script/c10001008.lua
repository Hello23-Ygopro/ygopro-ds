--BT1-006 Scheming Champa
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_CHAMPA)
	aux.AddSpecialTrait(c,TRAIT_GOD)
	aux.AddEra(c,ERA_CHAMPA_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--gain skill
	aux.AddAutoSkill(c,0,EVENT_PLAY,nil,scard.op1,nil,scard.con1)
end
scard.specified_cost={COLOR_RED,1}
scard.combo_cost=0
--gain skill
function scard.cfilter(c,tp)
	return c:IsColor(COLOR_RED) and c:IsSpecialTrait(TRAIT_ALIEN) and c:GetPlayPlayer()==tp
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(aux.BattleAreaFilter(scard.cfilter),1,nil,tp)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(scard.cfilter,nil,tp)
	for tc in aux.Next(g) do
		--gain power
		aux.AddTempSkillUpdatePower(e:GetHandler(),tc,1,5000)
	end
end
