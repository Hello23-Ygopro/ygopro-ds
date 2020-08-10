--BT5-106 Adventurous Son Goku
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_SON_GOKU_CHILDHOOD)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_PILAF_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOKU)
	--battle card
	aux.EnableBattleAttribute(c)
	--search (drop), gain skill
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--search (drop), gain skill
function scard.dropfilter(c)
	return c:IsHasEffect(EFFECT_DRAGON_BALL) and c:IsAbleToDrop()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.dropfilter,LOCATION_DECK,0,0,1,HINTMSG_DROP)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) or Duel.SendtoDrop(tc,REASON_EFFECT)==0 then return end
	local c=e:GetHandler()
	--gain power
	aux.AddTempSkillUpdatePower(c,c,1,10000)
	--double strike
	aux.AddTempSkillCustom(c,c,2,EFFECT_DOUBLE_STRIKE)
end
