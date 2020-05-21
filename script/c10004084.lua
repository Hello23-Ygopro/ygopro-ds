--BT4-075 Height of Mastery Son Goku
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_SON_GOKU)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_UNIVERSE_7,TRAIT_GOKUS_LINEAGE)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOKU,TRAIT_CATEGORY_UNIVERSE)
	--battle card
	aux.EnableBattleAttribute(c)
	--deflect
	aux.EnableDeflect(c)
	--triple strike
	aux.EnableTripleStrike(c)
	--dual attack
	aux.EnableDualAttack(c)
	--tap
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_IGNORE_BARRIER,aux.SwapPlayCondition)
end
scard.specified_cost={COLOR_YELLOW,3}
scard.combo_cost=1
--tap
function scard.tapfilter(c,e)
	return c:IsAbleToSwitchToRest() and c:IsCanBeEffectTarget(e)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	local g1=Duel.GetMatchingGroup(aux.BattleAreaFilter(scard.tapfilter),tp,0,LOCATION_BATTLE,nil,e)
	local g2=Duel.GetMatchingGroup(aux.EnergyAreaFilter(scard.tapfilter),tp,0,LOCATION_ENERGY,nil,e)
	g1:Merge(g2)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOREST)
	local sg=g1:Select(tp,0,3,nil)
	Duel.SetTargetCard(sg)
end
scard.op1=aux.TargetCardsOperation(Duel.SwitchtoRest,REASON_EFFECT)
