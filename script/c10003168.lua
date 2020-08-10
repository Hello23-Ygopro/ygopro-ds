--TB1-015 Relentless Super Saiyan Kale
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_RED,3)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_KALE)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_ALIEN,TRAIT_UNIVERSE_6)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,TRAIT_CATEGORY_UNIVERSE)
	--battle card
	aux.EnableBattleAttribute(c)
	--evolve
	aux.EnableEvolve(c,aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_KALE),aux.PaySkillCost(COLOR_RED,3,1))
	--double strike
	aux.EnableDoubleStrike(c)
	--ko
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,aux.EvolvePlayCondition)
end
--ko
function scard.kofilter(c,e,tp)
	if c:IsCharacter(CHARACTER_CAULIFLA) and c:IsControler(tp) then return false end
	return c:IsPowerBelow(25000) and c:IsCanBeEffectTarget(e)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	local g=Duel.GetMatchingGroup(aux.BattleAreaFilter(scard.kofilter),tp,LOCATION_BATTLE,LOCATION_BATTLE,e:GetHandler(),e,tp)
	Duel.SetTargetCard(g)
end
scard.op1=aux.TargetCardsOperation(Duel.KO,REASON_EFFECT)
