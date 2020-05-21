--BT2-068 Ultimate Lifeform Cell
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_CELL)
	aux.AddSpecialTrait(c,TRAIT_ANDROID)
	aux.AddEra(c,ERA_ANDROID_CELL_SAGA)
	--leader card
	aux.EnableLeaderAttribute(c)
	--draw
	local e1=aux.AddActivateMainSkill(c,0,scard.op1,scard.cost1)
	e1:SetCountLimit(1)
	--ko
	local e2=aux.AddActivateMainSkill(c,1,scard.op2,scard.cost2,scard.tg1)
	e2:SetCountLimit(1)
end
scard.front_side_code=sid-1
--draw
scard.cost1=aux.AbsorbCost(aux.HandFilter(nil),LOCATION_HAND,0,1)
scard.op1=aux.DuelOperation(Duel.Draw,PLAYER_SELF,2,REASON_EFFECT)
--ko
scard.cost2=aux.SelfDropAbsorbedCost(nil,2)
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(nil),0,LOCATION_BATTLE,0,1,HINTMSG_KO)
scard.op2=aux.TargetCardsOperation(Duel.KO,REASON_EFFECT)
