--EX03-28 Smiling Madness Towa
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_TOWA)
	aux.AddSpecialTrait(c,TRAIT_DEMON_REALM_RACE)
	aux.AddEra(c,ERA_DARK_DEMON_REALM_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--xeno-evolve
	aux.EnableXenoEvolve(c,aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_TOWA),aux.PaySkillCost(COLOR_COLORLESS,0,4))
	--double strike
	aux.EnableDoubleStrike(c)
	--drop, gain control
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_CHOOSE,scard.con1)
end
--drop, gain control
scard.con1=aux.AND(aux.EvolvePlayCondition,aux.SelfLeaderCondition(Card.IsSpecialTrait,TRAIT_ANDROID))
scard.tg1=aux.TargetCardFunction(PLAYER_OPPO,aux.HandFilter(Card.IsAbleToDrop),0,LOCATION_HAND,1,1,HINTMSG_DROP)
function scard.ctfilter(c,e)
	return c:IsEnergyBelow(3) and c:IsControlerCanBeChanged() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SendtoDrop(tc,REASON_EFFECT)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_GAINCONTROL)
	local g=Duel.SelectMatchingCard(tp,aux.BattleAreaFilter(scard.ctfilter),tp,0,LOCATION_BATTLE,0,1,nil,e)
	if g:GetCount()==0 then return end
	Duel.BreakEffect()
	Duel.SetTargetCard(g)
	Duel.GetControl(g,tp)
end
