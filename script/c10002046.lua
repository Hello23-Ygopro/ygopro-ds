--BT2-040 Restless Spirit SSB Vegeta
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_VEGETA)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_FUTURE_TRUNKS_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--double strike
	aux.EnableDoubleStrike(c)
	--play
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,nil,scard.op1)
end
scard.specified_cost={COLOR_BLUE,2}
scard.combo_cost=1
--play
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,LOCATION_DECK,0)
	if g:GetCount()==0 then return end
	local tc1=g:GetMinGroup(Card.GetSequence):GetFirst()
	Duel.MoveSequence(tc1,SEQ_DECK_TOP)
	Duel.ConfirmDecktop(tp,1)
	local tc2=Duel.GetDecktopGroup(tp,1):GetFirst()
	if tc2:IsCharacter(CHARACTER_TRUNKS_FUTURE) and tc2:IsEnergyBelow(3) then
		Duel.DisableShuffleCheck()
		if Duel.Play(tc2,0,tp,tp,false,false,POS_FACEUP_ACTIVE) then
			--negate skill
			aux.AddTempSkillCustom(e:GetHandler(),tc2,1,EFFECT_NEGATE_ACTIVATE_EFFECT,0)
		end
		Duel.PlayComplete()
	else Duel.MoveSequence(tc2,SEQ_DECK_BOTTOM) end
end
