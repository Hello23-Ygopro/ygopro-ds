--BT3-083 Uncontrollable Great Ape Son Goku
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_SON_GOKU_CHILDHOOD)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_GREAT_APE)
	aux.AddEra(c,ERA_YOUNG_SON_GOKU_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOKU)
	--leader card
	aux.EnableLeaderAttribute(c)
	--tap, gain skill
	local e1=aux.AddActivateMainSkill(c,0,scard.op1,scard.cost1,scard.tg1,EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
	--draw
	aux.AddSingleAutoSkill(c,1,EVENT_ATTACK_ANNOUNCE,nil,aux.DuelOperation(Duel.Draw,PLAYER_SELF,1,REASON_EFFECT))
end
scard.front_side_code=sid-1
--tap, gain skill
scard.cost1=aux.SwitchtoRestCost(aux.BattleAreaFilter(Card.IsAbleToSwitchToRest),LOCATION_BATTLE,0,1)
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(Card.IsAbleToSwitchToRest),0,LOCATION_BATTLE,0,1,HINTMSG_TOREST)
function scard.skfilter(c,e)
	return c:IsRest() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SwitchtoRest(tc,REASON_EFFECT)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectMatchingCard(tp,aux.BattleAreaFilter(scard.skfilter),tp,0,LOCATION_BATTLE,0,1,nil,e)
	if g:GetCount()==0 then return end
	Duel.BreakEffect()
	Duel.SetTargetCard(g)
	--cannot switch to active
	aux.AddTempSkillCustom(e:GetHandler(),g:GetFirst(),2,EFFECT_CANNOT_CHANGE_POS_E,0,1,aux.SelfRestCondition)
end
