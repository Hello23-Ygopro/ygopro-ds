--BT3-020 Hidden Ability, General Rilldo
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_RED,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_GENERAL_RILLDO)
	aux.AddSpecialTrait(c,TRAIT_MACHINE_MUTANT)
	aux.AddEra(c,ERA_BLACK_STAR_DRAGON_BALL_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--union-absorb
	aux.EnableUnionAbsorb(c,scard.uniafilter,scard.cost1)
end
--union-absorb
function scard.uniafilter(c)
	return c:IsCharacter(CHARACTER_GENERAL_RILLDO) and c:IsPower(25000)
end
function scard.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
	local f1=aux.DropAreaFilter(Card.IsCharacter,CHARACTER_NEZI)
	local f2=aux.DropAreaFilter(Card.IsCharacter,CHARACTER_NATT)
	local f3=aux.DropAreaFilter(Card.IsCharacter,CHARACTER_BIZU)
	local f4=aux.DropAreaFilter(Card.IsCharacter,CHARACTER_RIBET)
	if chk==0 then return Duel.IsExistingTarget(f1,tp,LOCATION_DROP,0,1,nil)
		and Duel.IsExistingTarget(f2,tp,LOCATION_DROP,0,1,nil)
		and Duel.IsExistingTarget(f3,tp,LOCATION_DROP,0,1,nil)
		and Duel.IsExistingTarget(f4,tp,LOCATION_DROP,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ABSORB)
	local g1=Duel.SelectTarget(tp,f1,tp,LOCATION_DROP,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ABSORB)
	local g2=Duel.SelectTarget(tp,f2,tp,LOCATION_DROP,0,1,1,nil)
	g1:Merge(g2)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ABSORB)
	local g3=Duel.SelectTarget(tp,f3,tp,LOCATION_DROP,0,1,1,nil)
	g1:Merge(g3)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ABSORB)
	local g4=Duel.SelectTarget(tp,f4,tp,LOCATION_DROP,0,1,1,nil)
	g1:Merge(g4)
	Duel.PlaceUnder(e:GetHandler(),g1)
end
