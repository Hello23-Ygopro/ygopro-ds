--BT5-046 Saike Demon, Rockin' Out
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_SAIKE_DEMON)
	aux.AddSpecialTrait(c,TRAIT_DEMON)
	aux.AddEra(c,ERA_JANEMBA_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--choose one (to hand)
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1)
end
--choose one (to hand)
function scard.thfilter(c,e)
	return c:IsCharacter(CHARACTER_JANEMBA) and c:IsAbleToHand() and c:IsCanBeEffectTarget(e)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0 then return end
	local opt=Duel.SelectOption(tp,aux.Stringid(sid,1),aux.Stringid(sid,2))+1
	e:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e:SetLabel(opt)
	local g=nil
	if opt==1 then
		g=Duel.GetDecktopGroup(tp,7)
	elseif opt==2 then
		g=Duel.GetFieldGroup(tp,LOCATION_DECK,0):GetMinGroup(Card.GetSequence)
	end
	Duel.ConfirmCards(tp,g)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local sg=g:FilterSelect(tp,scard.thfilter,0,1,nil,e)
	Duel.SetTargetCard(sg)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,PLAYER_OWNER,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
	Duel.ShuffleDeck(tp)
end
