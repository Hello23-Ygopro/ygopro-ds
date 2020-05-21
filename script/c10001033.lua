--BT1-029 Beerus
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_BEERUS)
	aux.AddSpecialTrait(c,TRAIT_GOD)
	aux.AddEra(c,ERA_BATTLE_OF_GODS_SAGA)
	--leader card
	aux.EnableLeaderAttribute(c)
	--ko
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
	--awaken
	aux.EnableAwaken(c)
end
scard.back_side_code=sid+1
--ko
scard.con1=aux.EnergyEqualAboveCondition(PLAYER_SELF,3)
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(Card.IsEnergyBelow,2),0,LOCATION_BATTLE,0,1,HINTMSG_KO)
scard.op1=aux.TargetCardsOperation(Duel.KO,REASON_EFFECT)
