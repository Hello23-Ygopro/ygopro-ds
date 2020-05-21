--TB2-005 Supreme Showdown Vegeta
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_VEGETA)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_WORLD_TOURNAMENT)
	aux.AddEra(c,ERA_THE_EVIL_WIZARD_BABIDI_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--triple strike
	aux.EnableTripleStrike(c)
	--gain power
	aux.AddPermanentUpdatePower(c,10000,aux.ExistingCardCondition(aux.BattleAreaFilter(Card.IsCode,CARD_SUPREME_SHOWDOWN_SON_GOKU),LOCATION_BATTLE))
	--drop, gain skill
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
scard.specified_cost={COLOR_RED,2}
scard.combo_cost=0
--drop, gain skill
scard.con1=aux.SelfLeaderCondition(Card.IsSpecialTrait,TRAIT_WORLD_TOURNAMENT)
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	local f=aux.BattleAreaFilter(Card.IsAbleToDrop)
	if chkc then return chkc:IsLocation(LOCATION_BATTLE) and chkc:IsControler(tp) and f(chkc) and chkc~=c end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DROP)
	Duel.SelectTarget(tp,f,tp,LOCATION_BATTLE,0,0,1,c)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) or Duel.SendtoDrop(tc,REASON_EFFECT)==0 then return end
	--cannot activate
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(aux.Stringid(sid,1))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CLIENT_HINT)
	e1:SetTargetRange(0,1)
	e1:SetValue(aux.CannotActivateKeySkillValue(CATEGORY_BLOCKER))
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
