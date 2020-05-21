--BT4-108 Mira, Creator Absorbed
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_MIRA)
	aux.AddSpecialTrait(c,TRAIT_ANDROID)
	aux.AddEra(c,ERA_DARK_DEMON_REALM_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--over realm
	aux.EnableOverRealm(c,4,aux.PaySkillCost(COLOR_COLORLESS,0,1))
	--deflect
	aux.EnableDeflect(c)
	--warp, gain skill
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,aux.UnionPlayCondition)
	--gain skill
	aux.AddSingleAutoSkill(c,1,EVENT_ATTACK_ANNOUNCE,nil,scard.op2)
end
scard.combo_cost=1
--warp, gain skill
scard.tg1=aux.TargetCardFunction(PLAYER_OPPO,aux.HandFilter(Card.IsAbleToWarp),0,LOCATION_HAND,3,3,HINTMSG_WARP)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if g then
		local sg=g:Filter(Card.IsRelateToEffect,nil,e)
		Duel.SendtoWarp(sg,REASON_EFFECT)
	end
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	--double strike
	aux.AddTempSkillCustom(c,c,2,EFFECT_DOUBLE_STRIKE)
end
--gain skill
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	--gain power
	aux.AddTempSkillUpdatePower(c,c,3,scard.val1)
end
function scard.val1(e,c)
	return Duel.GetWarpCount(c:GetControler())*5000
end
