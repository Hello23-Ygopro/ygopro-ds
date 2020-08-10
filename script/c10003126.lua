--BT3-114 Towa, Reprogrammed Menace
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
	--untap, gain control
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,aux.EvolvePlayCondition)
end
--untap, gain control
function scard.ctfilter(c)
	return (c:IsAbleToSwitchToActive() or c:IsControlerCanBeChanged()) and c:IsEnergyBelow(6)
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(scard.ctfilter),0,LOCATION_BATTLE,0,1,HINTMSG_GAINCONTROL)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) then return end
	Duel.SwitchtoActive(tc,REASON_EFFECT)
	Duel.GetControl(tc,tp)
end
