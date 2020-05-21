--BT2-059 God of the Gods Great Priest
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_GREAT_PRIEST)
	aux.AddSpecialTrait(c,TRAIT_GOD)
	aux.AddEra(c,ERA_FUTURE_TRUNKS_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--double strike
	aux.EnableDoubleStrike(c)
	--charge
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
scard.specified_cost={COLOR_BLUE,2}
scard.combo_cost=1
--charge
scard.con1=aux.SelfLeaderCondition(Card.IsSpecialTrait,TRAIT_GOD)
function scard.tefilter1(c)
	return c:IsSpecialTrait(TRAIT_GOD) and c:IsAbleToEnergy()
end
function scard.tefilter2(c,e)
	return scard.tefilter1(c) and c:IsCanBeEffectTarget(e)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	local f=aux.BattleAreaFilter(scard.tefilter1)
	if chkc then return chkc:IsLocation(LOCATION_BATTLE) and chkc:IsControler(tp) and f(chkc) and chkc~=c end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	local ct=Duel.GetMatchingGroupCount(aux.BattleAreaFilter(scard.tefilter2),tp,LOCATION_BATTLE,0,c,e)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOENERGY)
	Duel.SelectTarget(tp,f,tp,LOCATION_BATTLE,0,0,ct,c)
end
scard.op1=aux.TargetCardsOperation(Duel.SendtoEnergy,POS_FACEUP_REST,REASON_EFFECT)
