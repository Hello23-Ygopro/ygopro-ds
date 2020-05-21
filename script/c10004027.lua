--BT4-024 Hirudegarn
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_HIRUDEGARN)
	aux.AddSpecialTrait(c,TRAIT_PHANTOM_DEMON)
	aux.AddEra(c,ERA_HIRUDEGARN_SAGA)
	--leader card
	aux.EnableLeaderAttribute(c)
	--drop, draw
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,aux.SelfAttackTargetCondition(Card.IsLeader))
	--awaken
	aux.EnableAwaken(c,aux.AwakenLifeCondition(4),0,2)
end
scard.back_side_code=sid+1
--drop, draw
function scard.dropfilter(c)
	return c:IsBattle() and c:IsAbleToDrop()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.HandFilter(scard.dropfilter),LOCATION_HAND,0,0,1,HINTMSG_DROP)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) or Duel.SendtoDrop(tc,REASON_EFFECT)==0 then return end
	Duel.Draw(tp,2,REASON_EFFECT)
end
