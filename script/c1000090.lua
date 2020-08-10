--P-076 Reality Bender Janemba
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_JANEMBA)
	aux.AddSpecialTrait(c,TRAIT_EVIL_INCARNATE)
	aux.AddEra(c,ERA_JANEMBA_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--critical
	aux.EnableCritical(c)
	--deflect
	aux.EnableDeflect(c)
	--reduce energy cost
	aux.AddPermanentUpdateEnergyCost(c,-3,nil,scard.con1)
	--to deck, drop
	aux.AddAutoSkill(c,0,EVENT_PHASE+PHASE_END,nil,scard.op1,nil,aux.TurnPlayerCondition(PLAYER_SELF))
end
--reduce energy cost
function scard.con1(e)
	local tp=e:GetHandlerPlayer()
	return Duel.GetEnergyCount(1-tp)>=4
		and Duel.IsExistingMatchingCard(aux.BattleAreaFilter(nil),tp,0,LOCATION_BATTLE,1,nil)
		and not Duel.IsExistingMatchingCard(aux.BattleAreaFilter(nil),tp,LOCATION_BATTLE,0,1,nil)
end
--to deck, drop
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendtoDeck(e:GetHandler(),PLAYER_OWNER,SEQ_DECK_BOTTOM,REASON_EFFECT)
	Duel.SendDecktoptoDrop(1-tp,2,REASON_EFFECT)
end
