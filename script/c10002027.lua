--BT2-024 Attendants Spopovich and Yamu
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_SPOPOVICH,CHARACTER_YAMU)
	aux.AddSpecialTrait(c,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_THE_EVIL_WIZARD_BABIDI_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--absorb
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.op1)
end
scard.specified_cost={COLOR_RED,2}
scard.combo_cost=0
--absorb
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstMatchingCard(aux.FaceupFilter(Card.IsCode,CARD_MAJIN_BUUS_SEALED_BALL),tp,LOCATION_BATTLE,0,nil)
	local dc=Duel.GetDecktopGroup(tp,1):GetFirst()
	if not tc or not dc or not Duel.SelectYesNo(tp,YESNOMSG_ABSORB) then return end
	Duel.DisableShuffleCheck()
	Duel.PlaceUnder(tc,dc)
end
