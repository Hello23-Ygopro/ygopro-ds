--BT1-095 Elite Force Captain Ginyu
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,3)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_GINYU)
	aux.AddSpecialTrait(c,TRAIT_GINYU_FORCE,TRAIT_FRIEZAS_ARMY)
	aux.AddEra(c,ERA_FRIEZA_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--gain skill
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--gain skill
function scard.skfilter(c,e)
	return c:IsSpecialTrait(TRAIT_GINYU_FORCE) and c:IsCanBeEffectTarget(e)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	local g=Duel.GetMatchingGroup(aux.BattleAreaFilter(scard.skfilter),tp,LOCATION_BATTLE,0,nil,e)
	Duel.SetTargetCard(g)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if not g then return end
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	local c=e:GetHandler()
	for tc in aux.Next(sg) do
		--gain power
		aux.AddTempSkillUpdatePower(c,tc,1,10000)
		--double strike
		aux.AddTempSkillCustom(c,tc,2,EFFECT_DOUBLE_STRIKE)
	end
end
