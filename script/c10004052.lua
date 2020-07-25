--BT4-047 Lord Slug
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_LORD_SLUG)
	aux.AddSpecialTrait(c,TRAIT_NAMEKIAN,TRAIT_SLUGS_ARMY)
	aux.AddEra(c,ERA_LORD_SLUG_SAGA)
	--leader card
	aux.EnableLeaderAttribute(c)
	--gain skill
	local e1=aux.AddActivateMainSkill(c,0,scard.op1,scard.cost1,nil,EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
	--awaken
	aux.EnableAwaken(c)
end
scard.back_side_code=sid+1
--gain skill
scard.cost1=aux.SendtoHandCost(aux.LifeAreaFilter(nil),LOCATION_LIFE,0,1)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	--critical
	aux.AddTempSkillCritical(c,c,1)
end
