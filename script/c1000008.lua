--P-008 Clan of Terror Mecha Frieza
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_FRIEZA)
	aux.AddSpecialTrait(c,TRAIT_FRIEZA_CLAN,TRAIT_FRIEZAS_ARMY)
	aux.AddEra(c,ERA_ANDROID_CELL_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--double strike
	aux.EnableDoubleStrike(c)
	--confirm hand, play
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,nil,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
scard.specified_cost={COLOR_YELLOW,2}
scard.combo_cost=1
--confirm hand, play
function scard.playfilter(c,e,tp)
	return c:IsBattle() and c:IsCanBePlayed(e,0,tp,false,false) and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	Duel.ConfirmCards(tp,g1)
	local g2=Duel.GetMatchingGroup(aux.HandFilter(scard.playfilter),tp,0,LOCATION_HAND,nil,e,tp)
	if g2:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_PLAY)
		local sg=g2:Select(tp,0,1,nil)
		Duel.SetTargetCard(sg)
		Duel.Play(sg,0,1-tp,1-tp,false,false,POS_FACEUP_REST)
	end
	Duel.ShuffleHand(1-tp)
end
