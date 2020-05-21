--TB2-002_SPR Supreme Showdown Son Goku (Alias)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_SON_GOKU)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_WORLD_TOURNAMENT)
	aux.AddEra(c,ERA_THE_EVIL_WIZARD_BABIDI_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOKU)
	--battle card
	aux.EnableBattleAttribute(c)
	--triple strike
	aux.EnableTripleStrike(c)
	--gain power
	aux.AddPermanentUpdatePower(c,10000,aux.ExistingCardCondition(aux.BattleAreaFilter(Card.IsCode,CARD_SUPREME_SHOWDOWN_VEGETA),LOCATION_BATTLE))
	--play
	local e1=aux.AddAutoSkill(c,0,EVENT_DROP,nil,scard.op1,nil,scard.con1)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_HAND)
end
scard.specified_cost={COLOR_RED,2}
scard.combo_cost=0
--play
function scard.cfilter(c,tp)
	return c:IsBattle() and c:GetPreviousControler()==tp
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(scard.cfilter,1,nil,tp)
		and re and re:GetHandler():IsCode(CARD_SUPREME_SHOWDOWN_VEGETA)
		and aux.SelfLeaderCondition(Card.IsSpecialTrait,TRAIT_WORLD_TOURNAMENT)(e,tp,eg,ep,ev,re,r,rp)
		and not Duel.IsExistingMatchingCard(aux.BattleAreaFilter(Card.IsCode,sid),tp,LOCATION_BATTLE,0,1,nil)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and not Duel.IsExistingMatchingCard(aux.BattleAreaFilter(Card.IsCode,sid),tp,LOCATION_BATTLE,0,1,nil) then
		Duel.Play(c,0,tp,tp,false,false,POS_FACEUP_ACTIVE)
	end
end
