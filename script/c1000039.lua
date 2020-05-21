--P-028 Frieza
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_FRIEZA)
	aux.AddSpecialTrait(c,TRAIT_FRIEZA_CLAN,TRAIT_FRIEZAS_ARMY)
	aux.AddEra(c,ERA_FRIEZA_SAGA)
	--leader card
	aux.EnableLeaderAttribute(c)
	--gain skill
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CUSTOM+EVENT_ACTIVATE_EXTRA_CARD)
	e1:SetRange(LOCATION_LEADER)
	e1:SetCondition(scard.con1)
	e1:SetOperation(scard.op1)
	c:RegisterEffect(e1)
	--awaken
	aux.EnableAwaken(c)
end
scard.back_side_code=sid+1
--gain skill
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local p=e:GetHandlerPlayer()
	return Duel.GetTurnPlayer()~=p and rp==p and e:GetHandler():GetFlagEffect(sid)==0
end
function scard.thfilter(c,e)
	return c:IsAbleToHand() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(aux.LifeAreaFilter(scard.thfilter),tp,LOCATION_LIFE,0,nil,e)
	if g:GetCount()==0 or not Duel.SelectYesNo(tp,aux.Stringid(sid,1)) then return end
	Duel.Hint(HINT_CARD,0,sid)
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local sg=g:Select(tp,1,1,nil)
	Duel.SetTargetCard(sg)
	if Duel.SendtoHand(sg,PLAYER_OWNER,REASON_EFFECT)==0 then return end
	local c=e:GetHandler()
	local rc=re:GetHandler()
	--reduce energy cost
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_TOTAL_ENERGY_COST)
	e1:SetValue(-1)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	rc:RegisterEffect(e1)
	if rc:GetEnergy()<1 then
		--no specified cost
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_NO_SPECIFIED_COST)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		rc:RegisterEffect(e2)
	end
	--negate skill
	c:RegisterFlagEffect(sid,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(sid,2))
end
