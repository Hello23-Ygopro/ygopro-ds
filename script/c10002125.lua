--BT2-110 Cooler, Blood of the Tyrant Clan
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_COOLER)
	aux.AddSpecialTrait(c,TRAIT_FRIEZA_CLAN)
	aux.AddEra(c,ERA_COOLER_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--double strike
	aux.EnableDoubleStrike(c)
	--tap, play
	local e1=aux.AddActivateMainSkill(c,0,scard.op1,scard.cost1,nil,EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
end
scard.specified_cost={COLOR_YELLOW,3}
scard.combo_cost=1
--tap, play
scard.cost1=aux.RemoveFromGameCost(aux.BattleAreaFilter(nil),LOCATION_BATTLE,0,1)
function scard.tapfilter(c,e)
	return c:IsAbleToSwitchToRest() and c:IsCanBeEffectTarget(e)
end
function scard.playfilter(c,e,tp)
	return c:IsSpecialTrait(TRAIT_COOLERS_ARMORED_SQUADRON,TRAIT_FRIEZA_CLAN)
		and not c:IsCharacter(CHARACTER_COOLER) and c:IsCanBePlayed(e,0,tp,false,false) and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOREST)
	local g1=Duel.SelectMatchingCard(tp,aux.BattleAreaFilter(scard.tapfilter),tp,0,LOCATION_BATTLE,0,2,nil,e)
	if g1:GetCount()>0 then
		Duel.SetTargetCard(g1)
		Duel.SwitchtoRest(g1,REASON_EFFECT)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_PLAY)
	local g2=Duel.SelectMatchingCard(tp,aux.DropAreaFilter(scard.playfilter),tp,LOCATION_DROP,0,1,1,nil,e,tp)
	if g2:GetCount()==0 then return end
	Duel.SetTargetCard(g2)
	Duel.Play(g2,0,tp,tp,false,false,POS_FACEUP_ACTIVE)
end
