--BT5-021 Baba, Champions' Leader
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_FORTUNETELLER_BABA)
	aux.AddSpecialTrait(c,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_FORTUNETELLER_BABA_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--search (drop), play
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
scard.specified_cost={COLOR_RED,1}
scard.combo_cost=0
--search (drop), play
function scard.dropfilter(c)
	return c:IsCharacter(CHARACTER_BANDAGES,CHARACTER_SPIKE,CHARACTER_SON_GOHAN) and c:IsAbleToDrop()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.dropfilter,LOCATION_DECK,0,0,1,HINTMSG_DROP)
function scard.playfilter(c,e,tp)
	return c:IsCharacter(CHARACTER_BANDAGES) and c:IsCanBePlayed(e,0,tp,false,false) and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SendtoDrop(tc,REASON_EFFECT)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_PLAY)
	local g=Duel.SelectMatchingCard(tp,aux.DropAreaFilter(scard.playfilter),tp,LOCATION_DROP,0,0,1,nil,e,tp)
	if g:GetCount()==0 then return end
	Duel.BreakEffect()
	Duel.SetTargetCard(g)
	Duel.Play(g,0,tp,tp,false,false,POS_FACEUP_ACTIVE)
end
