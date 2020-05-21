--TB2-032 Awkward Situation Otokosuki
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_OTOKOSUKI)
	aux.AddSpecialTrait(c,TRAIT_EARTHLING,TRAIT_WORLD_TOURNAMENT)
	aux.AddEra(c,ERA_MAJIN_BUU_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--free play
	aux.AddPermanentFreePlay(c,scard.con1)
end
scard.specified_cost={COLOR_BLUE,1}
scard.combo_cost=0
--free play
function scard.con1(e)
	local tp=e:GetHandlerPlayer()
	return Duel.IsExistingMatchingCard(aux.BattleAreaFilter(Card.IsCode,CARD_AWKWARD_SITUATION_TRUNKS),tp,LOCATION_BATTLE,0,1,nil)
		and not Duel.IsExistingMatchingCard(aux.BattleAreaFilter(Card.IsCode,sid),tp,LOCATION_BATTLE,0,1,nil)
end
