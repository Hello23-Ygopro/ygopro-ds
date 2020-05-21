--BT2-080 Ready to Strike Piccolo
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_PICCOLO)
	aux.AddSpecialTrait(c,TRAIT_NAMEKIAN,TRAIT_GOD)
	aux.AddEra(c,ERA_ANDROID_CELL_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--drop
	aux.AddAutoSkill(c,0,EVENT_PHASE+PHASE_END,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,aux.TurnPlayerCondition(PLAYER_OPPO))
end
scard.specified_cost={COLOR_GREEN,1}
scard.combo_cost=0
--drop
function scard.dropfilter(c,e)
	return c:IsAbleToDrop() and c:IsCanBeEffectTarget(e)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	local ct=Duel.GetMatchingGroupCount(aux.HandFilter(scard.dropfilter),tp,0,LOCATION_HAND,nil,e)
	if ct<=6 then return end
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_DROP)
	Duel.SelectTarget(1-tp,aux.HandFilter(Card.IsAbleToDrop),1-tp,LOCATION_HAND,0,ct-6,ct-6,nil)
end
scard.op1=aux.TargetCardsOperation(Duel.SendtoDrop,REASON_EFFECT)
