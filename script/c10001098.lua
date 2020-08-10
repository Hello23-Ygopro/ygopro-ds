--BT1-085 Ginyu
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_GINYU)
	aux.AddSpecialTrait(c,TRAIT_GINYU_FORCE,TRAIT_FRIEZAS_ARMY)
	aux.AddEra(c,ERA_FRIEZA_SAGA)
	aux.AddCode(c,CARD_GINYU)
	--leader card
	aux.EnableLeaderAttribute(c)
	--play or to hand
	local e1=aux.AddActivateMainSkill(c,0,scard.op1,scard.cost1)
	e1:SetCountLimit(1)
	--awaken
	aux.EnableAwaken(c)
end
scard.back_side_code=sid+1
--play or to hand
function scard.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
	local f=aux.LifeAreaFilter(Card.IsFacedown)
	if chk==0 then return Duel.IsExistingMatchingCard(f,tp,LOCATION_LIFE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local tc=Duel.SelectMatchingCard(tp,f,tp,LOCATION_LIFE,0,1,1,nil):GetFirst()
	Duel.ConfirmCards(1-tp,tc)
	e:SetLabelObject(tc)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc:IsSpecialTrait(TRAIT_GINYU_FORCE) and not tc:IsCharacter(CHARACTER_GINYU) then
		Duel.Play(tc,0,tp,tp,false,false,POS_FACEUP_ACTIVE)
	else
		Duel.SendtoHand(tc,PLAYER_OWNER,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end
