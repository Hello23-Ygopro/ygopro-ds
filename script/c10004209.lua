--TB2-014 Dark Duo Dabura
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_DABURA)
	aux.AddSpecialTrait(c,TRAIT_DEMON_REALM_RACE,TRAIT_WORLD_TOURNAMENT)
	aux.AddEra(c,ERA_THE_EVIL_WIZARD_BABIDI_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--barrier
	aux.EnableBarrier(c,aux.ExistingCardCondition(aux.BattleAreaFilter(Card.IsCode,CARD_DARK_DUO_BABIDI),LOCATION_BATTLE))
	--warp
	local e1=aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
	--to hand
	local e2=aux.AddSingleAutoSkill(c,1,EVENT_LEAVE_FIELD,nil,scard.op2)
	local e3=aux.AddSingleAutoSkill(c,1,EVENT_CONTROL_CHANGED,nil,scard.op2)
	local g=Group.CreateGroup()
	g:KeepAlive()
	e1:SetLabelObject(g)
	e2:SetLabelObject(g)
	e3:SetLabelObject(g)
end
scard.specified_cost={COLOR_RED,2}
scard.combo_cost=0
--warp
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.HandFilter(Card.IsAbleToWarp),0,LOCATION_HAND,0,2,HINTMSG_WARP)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if not g then return end
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	if Duel.SendtoWarp(sg,REASON_EFFECT)==0 then return end
	for tc in aux.Next(sg) do
		tc:RegisterFlagEffect(sid,RESET_EVENT+RESETS_STANDARD,0,0)
		e:GetLabelObject():AddCard(tc)
	end
end
--to hand
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,g)
	g:Clear()
end
