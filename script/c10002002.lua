--BT2-002 Son Goku
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_SON_GOKU)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_THE_EVIL_WIZARD_BABIDI_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOKU)
	--leader card
	aux.EnableLeaderAttribute(c)
	--gain skill
	local e1=aux.AddActivateBattleSkill(c,0,scard.op1,scard.cost1)
	e1:SetCountLimit(1)
	--awaken
	aux.EnableAwaken(c)
end
scard.card_code=CARD_SON_GOKU
scard.back_side_code=sid+1
--gain skill
scard.cost1=aux.DropCost(aux.HandFilter(nil),LOCATION_HAND,0,1)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	--gain power
	aux.AddTempSkillUpdatePower(c,c,1,5000,RESET_PHASE+PHASE_DAMAGE)
end
