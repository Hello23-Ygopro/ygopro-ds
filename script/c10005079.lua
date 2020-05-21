--BT5-066 Hell Fighter 17, Evil Revived
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_HELL_FIGHTER_17)
	aux.AddSpecialTrait(c,TRAIT_ANDROID,TRAIT_MACHINE_MUTANT)
	aux.AddEra(c,ERA_SUPER_17_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--barrier
	aux.EnableBarrier(c)
	--union-absorb
	aux.EnableUnionAbsorb(c,scard.uniafilter1,scard.cost1,scard.tg1)
end
scard.specified_cost={COLOR_GREEN,2}
scard.combo_cost=0
--union-absorb
function scard.uniafilter1(c)
	return c:IsCharacter(CHARACTER_SUPER_17) and c:IsEnergy(4)
end
function scard.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
	local f1=aux.HandFilter(Card.IsCharacter,CHARACTER_ANDROID_17)
	local f2=aux.DropAreaFilter(Card.IsCharacter,CHARACTER_ANDROID_17)
	if chk==0 then return Duel.IsExistingMatchingCard(f1,tp,LOCATION_HAND,0,1,nil)
		or Duel.IsExistingMatchingCard(f2,tp,LOCATION_DROP,0,1,nil) end
	local g1=Duel.GetMatchingGroup(f1,tp,LOCATION_HAND,0,nil)
	local g2=Duel.GetMatchingGroup(f2,tp,LOCATION_DROP,0,nil)
	g1:Merge(g2)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ABSORB)
	local sg=g1:Select(tp,1,1,nil)
	Duel.PlaceUnder(e:GetHandler(),sg)
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
