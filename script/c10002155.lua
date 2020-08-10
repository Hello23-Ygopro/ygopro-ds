--EX02-01 Time Patrol Trunks
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_TRUNKS_XENO)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_DARK_DEMON_REALM_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--over realm
	aux.EnableOverRealm(c,3)
	--to hand
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,aux.OverRealmPlayCondition)
end
--to hand
scard.tg1=aux.TargetDecktopTarget(Card.IsAbleToHand,2,0,1,HINTMSG_ATOHAND)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local ct=0
	if tc and tc:IsRelateToEffect(e) then
		Duel.DisableShuffleCheck()
		ct=ct+Duel.SendtoHand(tc,PLAYER_OWNER,REASON_EFFECT)
		Duel.ShuffleHand(tp)
	end
	local opt=Duel.SelectOption(tp,aux.Stringid(sid,1),aux.Stringid(sid,2))+1
	local seq=(opt==1 and SEQ_DECK_TOP or SEQ_DECK_BOTTOM)
	aux.SortDeck(tp,tp,2-ct,seq)
end
