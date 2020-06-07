--P-024 Powerful Bond Ginyu Force
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_GINYU_FORCE)
	aux.AddSpecialTrait(c,TRAIT_GINYU_FORCE,TRAIT_FRIEZAS_ARMY)
	aux.AddEra(c,ERA_FRIEZA_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--add character
	aux.AddPermanentAddCharacter(c,CHARACTER_GINYU,CHARACTER_JEICE,CHARACTER_BURTER,CHARACTER_RECOOME,CHARACTER_GULDO)
	--gain skill
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
	aux.AddSingleAutoSkill(c,0,EVENT_CUSTOM+EVENT_COMBO,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con2)
end
scard.specified_cost={COLOR_YELLOW,2}
scard.combo_cost=1
--gain skill
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFlagEffect(tp,sid)==0
end
function scard.powfilter(c,e)
	return c:IsSpecialTrait(TRAIT_GINYU_FORCE) and c:IsCanBeEffectTarget(e)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	local g=Duel.GetMatchingGroup(aux.BattleAreaFilter(scard.powfilter),tp,LOCATION_BATTLE,0,nil,e)
	Duel.SetTargetCard(g)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if g then
		local sg=g:Filter(Card.IsRelateToEffect,nil,e)
		for tc in aux.Next(sg) do
			--gain power
			aux.AddTempSkillUpdatePower(e:GetHandler(),tc,1,5000)
		end
	end
	Duel.RegisterFlagEffect(tp,sid,RESET_PHASE+PHASE_END,0,1)
end
