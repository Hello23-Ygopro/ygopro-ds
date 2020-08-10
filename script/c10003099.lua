--BT3-089 Rampaging Great Ape Son Goku
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,3)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_SON_GOKU_CHILDHOOD)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_GREAT_APE)
	aux.AddEra(c,ERA_YOUNG_SON_GOKU_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOKU)
	--battle card
	aux.EnableBattleAttribute(c)
	--evolve
	aux.EnableEvolve(c,aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_SON_GOKU_CHILDHOOD),aux.PaySkillCost(COLOR_YELLOW,2,2))
	--critical
	aux.EnableCritical(c)
	--blocker
	aux.EnableBlocker(c)
	--gain skill
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,aux.EvolvePlayCondition)
end
--gain skill
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.EnergyAreaFilter(Card.IsRest),0,LOCATION_ENERGY,0,1,HINTMSG_TARGET)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) then return end
	--cannot switch to active
	aux.AddTempSkillCustom(e:GetHandler(),tc,1,EFFECT_CANNOT_CHANGE_POS_E,RESET_PHASE+PHASE_DRAW+RESET_SELF_TURN,1,aux.SelfRestCondition)
end
