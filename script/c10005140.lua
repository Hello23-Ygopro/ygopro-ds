--BT5-119 World Peace
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--extra card
	aux.EnableExtraAttribute(c)
	--add special trait
	aux.AddPermanentAddSpecialTrait(c,TRAIT_DESIRE)
	--play
	aux.AddActivateMainSkill(c,0,scard.op1,nil,scard.tg1,EFFECT_FLAG_CARD_TARGET,aux.SelfLeaderCondition(Card.IsSpecialTrait,TRAIT_SHENRON))
end
--play
function scard.playfilter(c,e,tp,cost)
	return c:IsBattle() and c:IsEnergyBelow(cost) and c:IsCanBePlayed(e,0,tp,false,false)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local cost=Duel.GetEnergyCount(tp)
	local f=aux.DropAreaFilter(scard.playfilter)
	if chkc then return chkc:IsLocation(LOCATION_DROP) and chkc:IsControler(tp) and f(chkc,e,tp,cost) end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_PLAY)
	Duel.SelectTarget(tp,f,tp,LOCATION_DROP,0,1,1,nil,e,tp,cost)
end
scard.op1=aux.TargetPlayOperation(POS_FACEUP_ACTIVE)
