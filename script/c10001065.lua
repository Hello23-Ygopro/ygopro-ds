--BT1-057 Broly
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_BROLY)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_BROLY_SAGA)
	--leader card
	aux.EnableLeaderAttribute(c)
	--attack limit
	aux.AddPermanentCannotSelectBattleTarget(c,scard.val1)
	--drop
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.op1,EFFECT_FLAG_CARD_TARGET)
	--awaken
	aux.EnableAwaken(c)
end
scard.back_side_code=sid+1
--attack limit
function scard.val1(e,c)
	return c:IsFaceup() and c:IsBattle()
end
--drop
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	scard.drop(e,tp)
	scard.drop(e,1-tp)
end
function scard.dropfilter(c,e)
	return c:IsAbleToDrop() and c:IsCanBeEffectTarget(e)
end
function scard.drop(e,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DROP)
	local g=Duel.SelectMatchingCard(tp,aux.HandFilter(scard.dropfilter),tp,LOCATION_HAND,0,1,1,nil,e)
	if g:GetCount()==0 then return end
	Duel.SetTargetCard(g)
	Duel.SendtoDrop(g,REASON_EFFECT)
end
