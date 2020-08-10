--BT5-013 Puar, Best Pal
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_RED,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_PUAR)
	aux.AddSpecialTrait(c,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_PILAF_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--to hand, play
	aux.AddSingleAutoSkill(c,0,EVENT_CUSTOM+EVENT_COMBO,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
--to hand, play
scard.con1=aux.SelfPreviousLocationCondition(LOCATION_BATTLE)
function scard.playfilter(c,e,tp)
	return aux.IsCode(c,CARD_YAMCHA) and c:IsColor(COLOR_RED) and c:IsEnergy(2)
		and c:IsCanBePlayed(e,0,tp,false,false) and c:IsCanBeEffectTarget(e)
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.LifeAreaFilter(Card.IsAbleToHand),LOCATION_LIFE,0,0,1,HINTMSG_ATOHAND)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) or Duel.SendtoHand(tc,PLAYER_OWNER,REASON_EFFECT)==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_PLAY)
	local g=Duel.SelectMatchingCard(tp,scard.playfilter,tp,LOCATION_DECK,0,0,1,nil,e,tp)
	if g:GetCount()==0 then return end
	Duel.SetTargetCard(g)
	Duel.Play(g,0,tp,tp,false,false,POS_FACEUP_ACTIVE)
end
