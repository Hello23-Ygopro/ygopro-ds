--EX03-19 Explosive Power Jiren
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_JIREN)
	aux.AddSpecialTrait(c,TRAIT_ALIEN,TRAIT_PRIDE_TROOPERS,TRAIT_UNIVERSE_11)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,TRAIT_CATEGORY_UNIVERSE)
	--leader card
	aux.EnableLeaderAttribute(c)
	--draw
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,aux.DuelOperation(Duel.Draw,PLAYER_SELF,1,REASON_EFFECT))
	--gain skill
	aux.AddActivateMainSkill(c,1,scard.op1,scard.cost1,nil,EFFECT_FLAG_CARD_TARGET)
end
scard.front_side_code=sid-1
--gain skill
function scard.costfilter(c)
	return c:IsSpecialTrait(TRAIT_UNIVERSE_11) and c:IsAbleToWarp()
end
scard.cost1=aux.SendtoWarpCost(aux.DropAreaFilter(scard.costfilter),LOCATION_DROP,0,9,9,true)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	--quadruple strike
	aux.AddTempSkillCustom(c,c,2,EFFECT_QUADRUPLE_STRIKE)
end
