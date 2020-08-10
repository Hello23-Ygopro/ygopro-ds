--BT5-047_SPR Infernal Chain Janemba (Alias)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,5)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_JANEMBA)
	aux.AddSpecialTrait(c,TRAIT_EVIL_INCARNATE)
	aux.AddEra(c,ERA_JANEMBA_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--critical
	aux.EnableCritical(c)
	--gain skill
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,nil,scard.op1)
	--sparking (play)
	aux.EnableSparking(c)
	aux.AddActivateMainSkill(c,1,scard.op2,scard.cost1,scard.tg1,EFFECT_FLAG_CARD_TARGET,aux.SparkingCondition(10))
end
--gain skill
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	--cannot play
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(aux.Stringid(sid,2))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_PLAY)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CLIENT_HINT)
	e1:SetTargetRange(1,0)
	e1:SetTarget(scard.val1)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function scard.val1(e,c,sump,sumtype,sumpos,targetp,se)
	return se~=CARD_INFERNAL_CHAIN_JANEMBA
end
--sparking (play)
scard.cost1=aux.SelfSendtoDeckCost(SEQ_DECK_BOTTOM)
function scard.playfilter(c,e,tp)
	return c:IsCharacter(CHARACTER_JANEMBA) and c:IsEnergy(4) and c:IsCanBePlayed(e,0,tp,false,false)
end
scard.con1=aux.SelfLeaderCondition(Card.IsSpecialTrait,TRAIT_EVIL_INCARNATE)
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.playfilter,LOCATION_WARP,0,0,1,HINTMSG_PLAY,scard.con1)
scard.op2=aux.TargetPlayOperation(POS_FACEUP_ACTIVE)
