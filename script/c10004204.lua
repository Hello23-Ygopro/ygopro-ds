--TB2-009 Secret Treaty Android 18
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_RED,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_ANDROID_18)
	aux.AddSpecialTrait(c,TRAIT_ANDROID,TRAIT_WORLD_TOURNAMENT)
	aux.AddEra(c,ERA_THE_EVIL_WIZARD_BABIDI_SAGA)
	aux.AddCategory(c,NAME_CATEGORY_ANDROID)
	--battle card
	aux.EnableBattleAttribute(c)
	--draw
	local e1=aux.AddSingleAutoSkill(c,0,EVENT_CHANGE_POS,nil,scard.op1,nil,scard.con1)
	e1:SetRange(LOCATION_BATTLE)
end
--draw
scard.op1=aux.DuelOperation(Duel.Draw,PLAYER_SELF,1,REASON_EFFECT)
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousPosition(POS_FACEUP_ACTIVE) and c:IsPosition(POS_FACEUP_REST)
		and re and re:GetHandler():IsCode(CARD_SECRET_TREATY_HERCULE)
end
