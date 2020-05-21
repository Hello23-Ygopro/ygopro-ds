--BT5-005 Feisty Chi-Chi
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_CHI_CHI)
	aux.AddSpecialTrait(c,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_PILAF_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--barrier
	aux.EnableBarrier(c)
	--search (play, draw)
	aux.AddSingleAutoSkill(c,0,EVENT_CUSTOM+EVENT_COMBO,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
scard.specified_cost={COLOR_RED,1}
scard.combo_cost=0
--search (play, draw)
scard.con1=aux.SelfPreviousLocationCondition(LOCATION_BATTLE)
function scard.playfilter(c,e,tp)
	return aux.IsCode(c,CARD_SON_GOKU) and c:IsColor(COLOR_RED) and c:IsEnergy(1) and c:IsCanBePlayed(e,0,tp,false,false)
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.playfilter,LOCATION_DECK,0,0,1,HINTMSG_PLAY)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and Duel.Play(tc,0,tp,tp,false,false,POS_FACEUP_ACTIVE)>0 then
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
