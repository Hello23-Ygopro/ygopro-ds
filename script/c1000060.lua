--P-041 Saiyan Teamwork Cabba
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_CABBA)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_ALIEN)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--reduce energy cost
	aux.AddPermanentUpdateEnergyCost(c,-1,nil,nil,LOCATION_BATTLE,LOCATION_HAND,0,aux.TargetBoolFunction(Card.IsCharacter,CHARACTER_CAULIFLA,CHARACTER_KALE))
	aux.AddPermanentUpdateEnergyCost(c,-1,COLOR_GREEN,nil,LOCATION_BATTLE,LOCATION_HAND,0,aux.TargetBoolFunction(Card.IsCharacter,CHARACTER_CAULIFLA,CHARACTER_KALE))
	--to hand or play
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
scard.specified_cost={COLOR_GREEN,2}
scard.combo_cost=0
--to hand or play
function scard.thfilter(c)
	return c:IsCharacter(CHARACTER_CAULIFLA,CHARACTER_KALE) and c:IsAbleToHand()
end
scard.tg1=aux.TargetDecktopTarget(scard.thfilter,10,0,1,HINTMSG_ATOHAND)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		if tc:IsCharacter(CHARACTER_CAULIFLA) and tc:IsCanBePlayed(e,0,tp,false,false)
			and Duel.SelectYesNo(tp,YESNOMSG_PLAY) then
			Duel.Play(tc,0,tp,tp,false,false,POS_FACEUP_ACTIVE)
		else
			Duel.SendtoHand(tc,PLAYER_OWNER,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,tc)
		end
	end
	Duel.ShuffleDeck(tp)
end
