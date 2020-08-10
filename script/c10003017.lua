--BT3-016 Power-absorbing Luud
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_RED,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_LUUD)
	aux.AddSpecialTrait(c,TRAIT_MACHINE_MUTANT)
	aux.AddEra(c,ERA_BLACK_STAR_DRAGON_BALL_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--cannot attack
	aux.AddSinglePermanentSkill(c,EFFECT_CANNOT_ATTACK,scard.con1)
	--gain skill
	local e1=aux.AddActivateMainSkill(c,0,scard.op1,scard.cost1,nil,EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
end
--cannot attack
function scard.con1(e)
	local g=e:GetHandler():GetAbsorbedGroup()
	return not g:IsExists(Card.IsCharacter,1,nil,CHARACTER_PAN)
end
--gain skill
scard.cost1=aux.AbsorbCost(aux.DropAreaFilter(Card.IsBattle),LOCATION_DROP,0,1)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	--double strike
	aux.AddTempSkillCustom(c,c,1,EFFECT_DOUBLE_STRIKE)
end
