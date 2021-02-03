--BT2-100 Nucleus of Evil Meta-Cooler Core
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_META_COOLER_CORE)
	aux.AddSpecialTrait(c,TRAIT_FRIEZA_CLAN)
	aux.AddEra(c,ERA_META_COOLER_SAGA)
	--leader card
	aux.EnableLeaderAttribute(c)
	--tap
	local e1=aux.AddActivateMainSkill(c,0,scard.op1,nil,scard.tg1,EFFECT_FLAG_CARD_TARGET,scard.con1)
	e1:SetCountLimit(1)
	--drop, to hand
	aux.AddSingleAutoSkill(c,1,EVENT_ATTACK_ANNOUNCE,nil,scard.op2,EFFECT_FLAG_CARD_TARGET)
end
scard.front_side_code=sid-1
--tap
scard.con1=aux.ExistingCardCondition(aux.FaceupFilter(Card.IsCharacter,CHARACTER_META_COOLER),LOCATION_INPLAY,0,3)
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(Card.IsAbleToSwitchToRest),0,LOCATION_BATTLE,1,1,HINTMSG_TOREST)
scard.op1=aux.TargetCardsOperation(Duel.SwitchtoRest,REASON_EFFECT)
--drop, to hand
function scard.thfilter(c,e)
	return c:IsCharacter(CHARACTER_META_COOLER,CHARACTER_META_COOLER_CORE) and c:IsAbleToHand() and c:IsCanBeEffectTarget(e)
end
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendDecktoDropUpTo(tp,3,REASON_EFFECT)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,aux.DropAreaFilter(scard.thfilter),tp,LOCATION_DROP,0,0,1,nil,e)
	if g:GetCount()==0 then return end
	Duel.SetTargetCard(g)
	Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,g)
end
