--TB1-025 Son Gohan
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_SON_GOHAN_ADOLESCENCE)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_EARTHLING,TRAIT_UNIVERSE_7)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOHAN,TRAIT_CATEGORY_UNIVERSE)
	--leader card
	aux.EnableLeaderAttribute(c)
	--warrior of universe 7
	aux.EnableWarriorofUniverse7(c)
	--draw
	local e1=aux.AddAutoSkill(c,0,EVENT_CUSTOM+EVENT_COMBO,nil,scard.op1,nil,scard.con1)
	e1:SetCountLimit(1)
	--awaken
	aux.EnableAwaken(c,aux.AwakenLifeCondition(4),0,2)
end
scard.back_side_code=sid+1
--draw
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp and eg:GetFirst():IsPreviousLocation(LOCATION_BATTLE) and ep==tp
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) and scard.con1(e,tp,eg,ep,ev,re,r,rp) and eg:GetFirst():IsSpecialTrait(TRAIT_UNIVERSE_7) then
		Duel.Draw(tp,2,REASON_EFFECT)
	end
end
