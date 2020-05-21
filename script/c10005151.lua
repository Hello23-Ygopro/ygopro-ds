--SD7-03 Vegeta, Returned from Darkness
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_VEGETA_XENO)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_DARK_DEMON_REALM_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--critical
	aux.EnableCritical(c)
	--burst (warp)
	aux.EnableBurst(c)
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,nil,aux.BurstCost(5))
end
scard.combo_cost=0
--burst (warp)
function scard.warpfilter(c,e)
	return c:IsAbleToWarp() and c:IsCanBeEffectTarget(e)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	local ct=Duel.GetMatchingGroupCount(aux.HandFilter(scard.warpfilter),tp,0,LOCATION_HAND,nil,e)
	if ct<=10 then return end
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_WARP)
	Duel.SelectTarget(1-tp,aux.HandFilter(Card.IsAbleToWarp),1-tp,LOCATION_HAND,0,ct-10,ct-10,nil)
end
scard.op1=aux.TargetCardsOperation(Duel.SendtoWarp,REASON_EFFECT)
