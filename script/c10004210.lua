--TB2-015 Tainted Power, Spopovich & Yamu
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_RED,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_SPOPOVICH,CHARACTER_YAMU)
	aux.AddSpecialTrait(c,TRAIT_EARTHLING,TRAIT_WORLD_TOURNAMENT)
	aux.AddEra(c,ERA_THE_EVIL_WIZARD_BABIDI_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--absorb
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--absorb
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,nil,LOCATION_BATTLE,0,0,1,HINTMSG_TARGET)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc1=Duel.GetFirstTarget()
	if not tc1 or not tc1:IsRelateToEffect(e) or Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0 then return end
	local g=Duel.GetDecktopGroup(tp,5)
	local tc2=g:GetFirst()
	local t={}
	for i=1,g:GetCount() do t[i]=i end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ANNOUNCEABSORB)
	local ct=Duel.AnnounceNumber(tp,table.unpack(t))
	for i=1,ct do
		Duel.DisableShuffleCheck()
		Duel.PlaceUnder(tc1,tc2)
		tc2=g:GetNext()
	end
end
