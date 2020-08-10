--BT1-092 Sorbet, The Loyal Commander
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_SORBET)
	aux.AddSpecialTrait(c,TRAIT_FRIEZAS_ARMY)
	aux.AddEra(c,ERA_RESURRECTION_F_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--combo
	local e1=aux.AddActivateBattleSkill(c,0,scard.op1,scard.cost1,scard.tg1,EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
end
--combo
scard.cost1=aux.DropCost(aux.HandFilter(nil),LOCATION_HAND,0,1)
function scard.tcfilter(c,tp)
	return c:IsSpecialTrait(TRAIT_FRIEZAS_ARMY) and c:IsCanCombo(tp)
end
scard.tg1=aux.TargetDecktopTarget(scard.tcfilter,2,0,2,HINTMSG_COMBO)
scard.op1=aux.TargetDecktopSendtoComboOperation(2,LOCATION_DROP)
