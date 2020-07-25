--BT5-084 Kick Barrage Piccolo
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_PICCOLO)
	aux.AddSpecialTrait(c,TRAIT_NAMEKIAN,TRAIT_GOD)
	aux.AddEra(c,ERA_RESURRECTION_F_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--ko
	local e1=aux.AddActivateMainSkill(c,0,scard.op1,scard.cost1,scard.tg1,EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
end
scard.specified_cost={COLOR_YELLOW,2}
scard.combo_cost=0
--ko
scard.cost1=aux.SendtoHandCost(aux.LifeAreaFilter(nil),LOCATION_LIFE,0,2)
function scard.kofilter(c,e)
	return c:IsRest() and c:IsPowerBelow(15000) and c:IsCanBeEffectTarget(e)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	local g=Duel.GetMatchingGroup(aux.BattleAreaFilter(scard.kofilter),tp,0,LOCATION_BATTLE,nil,e)
	Duel.SetTargetCard(g)
end
scard.op1=aux.TargetCardsOperation(Duel.KO,REASON_EFFECT)
