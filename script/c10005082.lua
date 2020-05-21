--BT5-068 Super 17, to Further Heights
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_SUPER_17)
	aux.AddSpecialTrait(c,TRAIT_ANDROID,TRAIT_MACHINE_MUTANT)
	aux.AddEra(c,ERA_SUPER_17_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--barrier
	aux.EnableBarrier(c)
	--deflect
	aux.EnableDeflect(c)
	--ko
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
	--union-absorb
	aux.EnableUnionAbsorb(c,scard.uniafilter1,aux.MergeCost(aux.PaySkillCost(COLOR_GREEN,2,2),scard.cost1),scard.tg1)
end
scard.specified_cost={COLOR_GREEN,2}
scard.combo_cost=0
--ko
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(nil),0,LOCATION_BATTLE,0,1,HINTMSG_KO)
scard.op1=aux.TargetCardsOperation(Duel.KO,REASON_EFFECT)
--union-absorb
function scard.uniafilter1(c)
	return c:IsCharacter(CHARACTER_SUPER_17) and c:IsEnergy(6)
end
function scard.costfilter(c,e)
	return c:IsCharacter(CHARACTER_CELL) and c:IsCanBeEffectTarget(e)
end
function scard.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(aux.HandFilter(Card.IsCharacter,CHARACTER_CELL),tp,LOCATION_HAND,0,1,nil)
		or Duel.IsExistingTarget(aux.DropAreaFilter(Card.IsCharacter,CHARACTER_CELL),tp,LOCATION_DROP,0,1,nil) end
	local g1=Duel.GetMatchingGroup(aux.HandFilter(scard.costfilter),tp,LOCATION_HAND,0,nil,e)
	local g2=Duel.GetMatchingGroup(aux.DropAreaFilter(scard.costfilter),tp,LOCATION_DROP,0,nil,e)
	g1:Merge(g2)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ABSORB)
	local sg=g1:Select(tp,1,1,nil)
	Duel.SetTargetCard(sg)
	Duel.PlaceUnder(e:GetHandler(),sg)
	Duel.ClearTargetCard()
end
function scard.uniafilter2(c,e,tp)
	return scard.uniafilter1(c) and c:IsCanBePlayed(e,0,tp,false,false) and c:IsCanBeEffectTarget(e)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	local g1=Duel.GetMatchingGroup(scard.uniafilter2,tp,LOCATION_DECK,0,nil,e,tp)
	local g2=Duel.GetMatchingGroup(aux.DropAreaFilter(scard.uniafilter2),tp,LOCATION_DROP,0,nil,e,tp)
	g1:Merge(g2)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_PLAY)
	local sg=g1:Select(tp,0,1,nil)
	Duel.SetTargetCard(sg)
end
