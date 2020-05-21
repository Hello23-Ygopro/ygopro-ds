--BT3-001 Pan, Ready to Fight
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_PAN)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_BLACK_STAR_DRAGON_BALL_SAGA)
	--leader card
	aux.EnableLeaderAttribute(c)
	--gain skill, draw
	local e1=aux.AddAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
	e1:SetCountLimit(1)
	--draw
	aux.AddSingleAutoSkill(c,1,EVENT_ATTACK_ANNOUNCE,nil,aux.DuelOperation(Duel.Draw,PLAYER_SELF,1,REASON_EFFECT))
end
scard.front_side_code=sid-1
--gain skill, draw
function scard.cfilter(c,tp)
	return c:GetPlayPlayer()==tp
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(aux.BattleAreaFilter(scard.cfilter),1,nil,tp)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return eg:IsContains(chkc) and aux.BattleAreaFilter(scard.cfilter)(chkc,tp) end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.SetTargetCard(eg)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if not g then return end
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	local check=false
	for tc in aux.Next(sg) do
		--gain power
		aux.AddTempSkillUpdatePower(c,tc,1,5000)
		if tc:IsPowerAbove(20000) then check=true end
	end
	if check then
		Duel.BreakEffect()
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
