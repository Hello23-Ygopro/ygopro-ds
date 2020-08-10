--TB1-081 Absolute Justice Jiren
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,5)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_JIREN)
	aux.AddSpecialTrait(c,TRAIT_ALIEN,TRAIT_PRIDE_TROOPERS,TRAIT_UNIVERSE_11)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,TRAIT_CATEGORY_UNIVERSE)
	--battle card
	aux.EnableBattleAttribute(c)
	--quadruple strike
	aux.EnableQuadStrike(c)
	--reduce energy cost
	aux.AddPermanentUpdateEnergyCost(c,scard.val1)
	--drop
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--reduce energy cost
function scard.val1(e,c)
	return Duel.GetMatchingGroupCount(aux.BattleAreaFilter(Card.IsSpecialTrait,TRAIT_UNIVERSE_11),c:GetControler(),LOCATION_BATTLE,0,nil)*-1
end
--drop
function scard.dropfilter(c,e)
	return c:IsRest() and c:IsCanBeEffectTarget(e)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	local g1=Duel.GetMatchingGroup(aux.BattleAreaFilter(scard.dropfilter),tp,0,LOCATION_BATTLE,nil,e)
	local g2=Duel.GetMatchingGroup(aux.EnergyAreaFilter(scard.dropfilter),tp,0,LOCATION_ENERGY,nil,e)
	g1:Merge(g2)
	Duel.SetTargetCard(g1)
end
scard.op1=aux.TargetCardsOperation(Duel.SendtoDrop,REASON_EFFECT)
