--BT4-119 Tokitoki, Time Creator
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_TOKITOKI)
	aux.AddSpecialTrait(c,TRAIT_GOD)
	aux.AddEra(c,ERA_DARK_DEMON_REALM_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--deflect
	aux.EnableDeflect(c)
	--to deck
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,nil,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--to deck
function scard.playfilter(c,e,tp)
	return c:IsBattle() and c:IsColor(COLOR_BLACK) and c:IsPower(3000) and c:IsCanBePlayed(e,0,tp,false,false)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsAbleToDeck() or not Duel.SelectYesNo(tp,YESNOMSG_TODECK) then return end
	if Duel.SendtoDeck(c,PLAYER_OWNER,SEQ_DECK_TOP,REASON_EFFECT)==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_PLAY)
	local g=Duel.SelectMatchingCard(tp,scard.playfilter,tp,LOCATION_DECK,0,0,1,nil,e,tp)
	if g:GetCount()==0 then return end
	Duel.SetTargetCard(g)
	Duel.Play(g,0,tp,tp,false,false,POS_FACEUP_ACTIVE)
end
