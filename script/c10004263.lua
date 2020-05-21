--TB2-059 Doublechop Nam
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_NAM)
	aux.AddSpecialTrait(c,TRAIT_EARTHLING,TRAIT_WORLD_TOURNAMENT)
	aux.AddEra(c,ERA_WORLD_MA_TOURNAMENT_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--dual attack
	aux.EnableDualAttack(c,aux.SelfLeaderCondition(scard.lfilter))
	--barrier
	aux.EnableBarrier(c,aux.SelfLeaderCondition(scard.lfilter))
	--ko
	local e1=aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
end
scard.specified_cost={COLOR_YELLOW,2}
scard.combo_cost=0
--dual attack, barrier
function scard.lfilter(c)
	return c:IsColor(COLOR_YELLOW) and c:IsSpecialTrait(TRAIT_WORLD_TOURNAMENT)
end
--ko
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(Card.IsRest),0,LOCATION_BATTLE,0,1,HINTMSG_KO)
scard.op1=aux.TargetCardsOperation(Duel.KO,REASON_EFFECT)
