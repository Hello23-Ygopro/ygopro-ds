--TB2-037 Fateful Reunion Chi-Chi
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_CHI_CHI)
	aux.AddSpecialTrait(c,TRAIT_EARTHLING,TRAIT_WORLD_TOURNAMENT)
	aux.AddEra(c,ERA_WORLD_MA_TOURNAMENT_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--barrier
	aux.EnableBarrier(c)
	--gain skill, draw
	aux.AddAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
scard.specified_cost={COLOR_GREEN,1}
scard.combo_cost=0
--gain skill, draw
function scard.cfilter(c,tp)
	return c:IsCode(CARD_FATEFUL_REUNION_SON_GOKU) and c:IsControler(tp)
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(aux.BattleAreaFilter(scard.cfilter),1,nil,tp)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	local c=e:GetHandler()
	if c:IsCanBeEffectTarget(e) then Duel.SetTargetCard(c) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,aux.FaceupFilter(Card.IsCode,CARD_FATEFUL_REUNION_SON_GOKU),tp,LOCATION_INPLAY,0,1,1,nil)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if g then
		local sg=g:Filter(Card.IsRelateToEffect,nil,e)
		for tc in aux.Next(sg) do
			--gain power
			aux.AddTempSkillUpdatePower(e:GetHandler(),tc,1,10000)
		end
	end
	Duel.BreakEffect()
	Duel.Draw(tp,1,REASON_EFFECT)
end
