--BT5-094 Frieza, Revenge in Motion
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_FRIEZA)
	aux.AddSpecialTrait(c,TRAIT_FRIEZA_CLAN,TRAIT_FRIEZAS_ARMY)
	aux.AddEra(c,ERA_RESURRECTION_F_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--draw, search (drop)
	aux.AddActivateMainSkill(c,0,scard.op1,aux.SelfDropCost,nil,EFFECT_FLAG_CARD_TARGET)
end
scard.specified_cost={COLOR_YELLOW,1}
scard.combo_cost=0
--draw, search (drop)
function scard.dropfilter(c,e)
	return c:IsCharacter(CHARACTER_FRIEZA) and c:IsEnergyBelow(4) and c:IsAbleToDrop() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DROP)
	local g=Duel.SelectMatchingCard(tp,scard.dropfilter,tp,LOCATION_DECK,0,0,1,nil,e)
	if g:GetCount()==0 then return end
	Duel.BreakEffect()
	Duel.SetTargetCard(g)
	Duel.SendtoDrop(g,REASON_EFFECT)
end
