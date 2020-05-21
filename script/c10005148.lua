--SD7-01 Dragon Ball
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_DRAGON_BALL)
	aux.AddSpecialTrait(c,TRAIT_SHENRON)
	aux.AddEra(c,ERA_SPECIAL)
	--leader card
	aux.EnableLeaderAttribute(c)
	--cannot attack
	aux.AddSinglePermanentSkill(c,EFFECT_CANNOT_ATTACK)
	--search (to hand)
	aux.AddActivateMainSkill(c,0,scard.op1,aux.SelfSwitchtoRestCost,scard.tg1,EFFECT_FLAG_CARD_TARGET)
	--wish
	aux.EnableWish(c)
end
scard.back_side_code=sid+1
--search (to hand)
function scard.thfilter(c,e)
	return c:IsHasEffect(EFFECT_DRAGON_BALL) and c:IsAbleToHand() and c:IsCanBeEffectTarget(e)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	local g1=Duel.GetMatchingGroup(scard.thfilter,tp,LOCATION_DECK,0,nil,e)
	local g2=Duel.GetMatchingGroup(aux.LifeAreaFilter(scard.thfilter),tp,LOCATION_LIFE,0,nil,e)
	g1:Merge(g2)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local sg=g1:Select(tp,0,2,nil)
	Duel.SetTargetCard(sg)
end
scard.op1=aux.TargetSendtoHandOperation(true)
