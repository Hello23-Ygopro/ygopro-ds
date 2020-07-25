--TB2-057 Master Roshi, Martial Meister
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_MASTER_ROSHI)
	aux.AddSpecialTrait(c,TRAIT_EARTHLING,TRAIT_WORLD_TOURNAMENT)
	aux.AddEra(c,ERA_WORLD_MA_TOURNAMENT_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--barrier
	aux.EnableBarrier(c)
	--draw
	local e1=aux.AddActivateMainSkill(c,0,scard.op1,scard.cost1,nil,EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
end
scard.specified_cost={COLOR_YELLOW,1}
scard.combo_cost=0
--draw
scard.cost1=aux.SwitchtoRestCost(aux.BattleAreaFilter(Card.IsCode,CARD_MASTER_SHEN_MARTIAL_MEISTER),LOCATION_BATTLE,0,1)
scard.op1=aux.DuelOperation(Duel.Draw,PLAYER_SELF,1,REASON_EFFECT)
