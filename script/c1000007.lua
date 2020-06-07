--P-007 Forceful Strike Cell
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_CELL)
	aux.AddSpecialTrait(c,TRAIT_ANDROID)
	aux.AddEra(c,ERA_ANDROID_CELL_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--double strike
	aux.EnableDoubleStrike(c)
	--revenge
	aux.EnableRevenge(c)
	--drop
	local e1=aux.AddAutoSkill(c,0,EVENT_CUSTOM+EVENT_COMBO,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
	e1:SetCountLimit(1)
end
scard.specified_cost={COLOR_GREEN,3}
scard.combo_cost=1
--drop
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return (Duel.GetAttacker()==c or Duel.GetAttackTarget()==c) and ep~=tp
end
scard.con2=aux.TurnPlayerCondition(PLAYER_SELF)
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.ComboAreaFilter(Card.IsAbleToDrop),0,LOCATION_COMBO,1,1,HINTMSG_DROP,scard.con2)
scard.op1=aux.TargetCardsOperation(Duel.SendtoDrop,REASON_EFFECT)
