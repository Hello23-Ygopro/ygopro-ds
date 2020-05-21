--BT3-085 Great Protector, Great Ape Bardock
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_BARDOCK)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_GREAT_APE)
	aux.AddEra(c,ERA_BARDOCK_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--ex-evolve
	aux.EnableEXEvolve(c,scard.evofilter,aux.DropCost(aux.HandFilter(nil),LOCATION_HAND,0,2))
	--blocker
	aux.EnableBlocker(c)
	--double strike
	aux.EnableDoubleStrike(c)
	--gain skill
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,aux.EvolvePlayCondition)
end
scard.specified_cost={COLOR_YELLOW,2}
scard.combo_cost=1
--ex-evolve
function scard.evofilter(c)
	return c:IsColor(COLOR_YELLOW) and c:IsCharacter(CHARACTER_BARDOCK) and c:IsEnergyAbove(5)
end
--gain skill
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.LeaderAreaFilter(Card.IsRest),0,LOCATION_LEADER,1,1,HINTMSG_TARGET)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) then return end
	--cannot switch to active
	aux.AddTempSkillCustom(e:GetHandler(),tc,1,EFFECT_CANNOT_CHANGE_POS_E,RESET_PHASE+PHASE_DRAW+RESET_OPPO_TURN,1,aux.SelfRestCondition)
end
