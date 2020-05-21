--BT3-008 Fearless Pan
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_PAN)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_BLACK_STAR_DRAGON_BALL_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--barrier
	aux.EnableBarrier(c)
	--gain skill
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
scard.specified_cost={COLOR_RED,2}
scard.combo_cost=0
--gain skill
function scard.skfilter(c,e)
	return (c:IsLeader() or c:IsBattle()) and c:IsColor(COLOR_RED) and c:IsCanBeEffectTarget(e)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	local g=Duel.GetMatchingGroup(aux.FaceupFilter(scard.skfilter),tp,LOCATION_INPLAY,0,e:GetHandler(),e)
	Duel.SetTargetCard(g)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if not g then return end
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	local c=e:GetHandler()
	for tc in aux.Next(sg) do
		--gain power
		aux.AddTempSkillUpdatePower(c,tc,1,5000)
		--double strike
		aux.AddTempSkillCustom(c,tc,2,EFFECT_DOUBLE_STRIKE)
	end
end
