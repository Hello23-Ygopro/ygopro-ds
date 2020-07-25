--BT4-071 Bardock
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_BARDOCK)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_GOKUS_LINEAGE)
	aux.AddEra(c,ERA_BARDOCK_SAGA)
	--leader card
	aux.EnableLeaderAttribute(c)
	--ko
	local e1=aux.AddActivateMainSkill(c,0,scard.op1,scard.cost1,scard.tg1,EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
	--awaken
	aux.EnableAwaken(c)
end
scard.back_side_code=sid+1
--ko
scard.cost1=aux.SendtoHandCost(aux.LifeAreaFilter(nil),LOCATION_LIFE,0,1)
function scard.kofilter(c)
	return c:IsRest() and c:IsEnergyBelow(3)
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(scard.kofilter),0,LOCATION_BATTLE,0,1,HINTMSG_KO)
scard.op1=aux.TargetCardsOperation(Duel.KO,REASON_EFFECT)
