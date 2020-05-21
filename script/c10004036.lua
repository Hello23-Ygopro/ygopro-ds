--BT4-032 Oath's Power Trunks
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_TRUNKS_YOUTH)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_HIRUDEGARN_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--double strike
	aux.EnableDoubleStrike(c,scard.con1)
	--barrier
	aux.EnableBarrier(c,scard.con1)
	--untap
	aux.AddAutoSkill(c,0,EVENT_PHASE+PHASE_END,nil,aux.SelfSwitchtoActiveOperation,nil,aux.AND(aux.TurnPlayerCondition(PLAYER_SELF),aux.SelfRestCondition))
end
scard.specified_cost={COLOR_BLUE,2}
scard.combo_cost=0
--double strike, barrier
function scard.con1(e)
	local tp=e:GetHandlerPlayer()
	return Duel.IsExistingMatchingCard(aux.DropAreaFilter(Card.IsCharacter,CHARACTER_TAPION),tp,LOCATION_DROP,0,1,nil)
		or Duel.IsExistingMatchingCard(Card.IsCharacter,tp,LOCATION_WARP,0,1,nil,CHARACTER_TAPION)
end
