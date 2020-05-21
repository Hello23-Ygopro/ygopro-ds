--BT2-098 Father-Son Kamehameha
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--extra card
	aux.EnableExtraAttribute(c)
	--ko
	aux.AddActivateMainSkill(c,0,scard.op1,nil,scard.tg1,EFFECT_FLAG_CARD_TARGET)
end
scard.specified_cost={COLOR_GREEN,1}
--ko
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local cost=Duel.GetEnergyCount(1-tp)
	local f=aux.BattleAreaFilter(Card.IsEnergyAbove,cost)
	if chkc then return chkc:IsLocation(LOCATION_BATTLE) and chkc:IsControler(1-tp) and f(chkc,cost) end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_KO)
	Duel.SelectTarget(tp,f,tp,0,LOCATION_BATTLE,1,1,nil,cost)
end
scard.op1=aux.TargetCardsOperation(Duel.KO,REASON_EFFECT)
