--P-003 Super Saiyan 3 Son Goku
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_RED,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_SON_GOKU)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_BABIDI_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOKU)
	--battle card
	aux.EnableBattleAttribute(c)
	--gain skill
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,nil,scard.op1)
	--return
	aux.AddAutoSkill(c,1,EVENT_PHASE+PHASE_END,nil,aux.SelfSendtoHandOperation,nil,aux.TurnPlayerCondition(PLAYER_SELF))
end
--gain skill
function scard.powfilter(c)
	return (c:IsLeader() or c:IsBattle()) and c:IsColor(COLOR_RED)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(aux.FaceupFilter(scard.powfilter),tp,LOCATION_INPLAY,0,nil)
	for tc in aux.Next(g) do
		--gain power
		aux.AddTempSkillUpdatePower(e:GetHandler(),tc,2,5000)
	end
end
