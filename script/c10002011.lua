--BT2-009 Ultimate Evil Dark Prince Vegeta
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_VEGETA)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_THE_EVIL_WIZARD_BABIDI_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--double strike
	aux.EnableDoubleStrike(c)
	--absorb
	aux.AddSingleAutoSkill(c,0,EVENT_BATTLE_KOING,nil,scard.op1,nil,aux.bdocon)
end
scard.specified_cost={COLOR_RED,2}
scard.combo_cost=1
--absorb
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstMatchingCard(aux.FaceupFilter(Card.IsCode,CARD_MAJIN_BUUS_SEALED_BALL),tp,LOCATION_BATTLE,0,nil)
	local ct=tc:GetAbsorbedGroup():GetCount()
	local g=Duel.GetDecktopGroup(tp,5-ct)
	if not tc or g:GetCount()==0 then return end
	for dc in aux.Next(g) do
		Duel.DisableShuffleCheck()
		Duel.PlaceUnder(tc,dc)
	end
end
