--BT5-099 Vicious Lackey Tagoma
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_TAGOMA)
	aux.AddSpecialTrait(c,TRAIT_FRIEZAS_ARMY)
	aux.AddEra(c,ERA_RESURRECTION_F_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--search (to hand)
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,aux.SelfPreviousLocationCondition(LOCATION_HAND))
end
scard.specified_cost={COLOR_YELLOW,1}
scard.combo_cost=0
--search (to hand)
function scard.thfilter(c,e)
	return c:IsColor(COLOR_YELLOW) and c:IsSpecialTrait(TRAIT_DESIRE)
		and c:IsAbleToHand() and c:IsCanBeEffectTarget(e)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	local g1=Duel.GetMatchingGroup(scard.thfilter,tp,LOCATION_DECK,0,nil,e)
	local g2=Duel.GetMatchingGroup(aux.DropAreaFilter(scard.thfilter),tp,LOCATION_DROP,0,nil,e)
	g1:Merge(g2)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local sg=g1:Select(tp,0,1,nil)
	Duel.SetTargetCard(sg)
end
scard.op1=aux.TargetSendtoHandOperation(true)
