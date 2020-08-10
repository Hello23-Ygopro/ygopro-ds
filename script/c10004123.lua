--BT4-110 Dark Absorption Mira
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_MIRA)
	aux.AddSpecialTrait(c,TRAIT_ANDROID)
	aux.AddEra(c,ERA_DARK_DEMON_REALM_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--over realm
	aux.EnableOverRealm(c,3)
	--union-absorb
	aux.EnableUnionAbsorb(c,scard.uniafilter1,scard.cost1,scard.tg1)
end
--union-absorb
function scard.uniafilter1(c)
	return c:IsCharacter(CHARACTER_MIRA) and c:IsEnergy(7)
end
function scard.costfilter(c)
	return c:IsCharacter(CHARACTER_TOWA)
end
scard.cost1=aux.MergeCost(aux.PaySkillCost(COLOR_COLORLESS,0,4),aux.AbsorbCost(scard.costfilter,LOCATION_WARP,0,1))
function scard.lfilter(c)
	return c:IsSpecialTrait(TRAIT_ANDROID) or c:IsCharacter(CHARACTER_TOWA)
end
function scard.uniafilter2(c,e,tp)
	return scard.uniafilter1(c) and c:IsCanBePlayed(e,0,tp,false,false) and c:IsCanBeEffectTarget(e)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	if not aux.SelfLeaderCondition(scard.lfilter)(e,tp,eg,ep,ev,re,r,rp) then return end
	local g1=Duel.GetMatchingGroup(aux.HandFilter(scard.uniafilter2),tp,LOCATION_HAND,0,nil,e,tp)
	local g2=Duel.GetMatchingGroup(scard.uniafilter2,tp,LOCATION_WARP,0,nil,e,tp)
	local min=1
	if g1:GetCount()>0 and g2:GetCount()==0 then min=0 end --min is always 0 for private areas
	g1:Merge(g2)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_PLAY)
	local sg=g1:Select(tp,min,1,nil)
	Duel.SetTargetCard(sg)
end
