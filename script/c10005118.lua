--BT5-100 Savage Shisami
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_SHISAMI)
	aux.AddSpecialTrait(c,TRAIT_FRIEZAS_ARMY)
	aux.AddEra(c,ERA_RESURRECTION_F_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--double strike
	aux.EnableDoubleStrike(c)
	--sparking (tap)
	aux.EnableSparking(c)
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_IGNORE_BARRIER,scard.con1)
end
scard.specified_cost={COLOR_YELLOW,2}
scard.combo_cost=0
--sparking (tap)
scard.con1=aux.AND(aux.SparkingCondition(5),aux.SelfLeaderCondition(Card.IsSpecialTrait,TRAIT_FRIEZAS_ARMY))
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(Card.IsAbleToSwitchToRest),0,LOCATION_BATTLE,0,2,HINTMSG_TOREST)
scard.op1=aux.TargetCardsOperation(Duel.SwitchtoRest,REASON_EFFECT)
