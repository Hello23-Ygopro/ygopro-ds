--SD2-01 Rising Spirit Super Saiyan Son Goku
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_SON_GOKU_GT)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_BLACK_STAR_DRAGON_BALL_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_GT,CHAR_CATEGORY_SON_GOKU)
	--leader card
	aux.EnableLeaderAttribute(c)
	--gain power
	aux.AddPermanentUpdatePower(c,5000,scard.con1)
	--draw, gain skill
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.op1)
end
scard.front_side_code=sid-1
--gain power
scard.con1=aux.AND(aux.TurnPlayerCondition(PLAYER_SELF),aux.LifeEqualBelowCondition(PLAYER_SELF,3))
--draw, gain skill
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() and c:IsPowerAbove(25000) then
		--double strike
		aux.AddTempSkillCustom(c,c,1,EFFECT_DOUBLE_STRIKE)
	end
end
