--TB2-056 Toughened Up Chiaotzu
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_CHIAOTZU)
	aux.AddSpecialTrait(c,TRAIT_EARTHLING,TRAIT_WORLD_TOURNAMENT)
	aux.AddEra(c,ERA_WORLD_MA_TOURNAMENT_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--draw
	local e1=aux.AddAutoSkill(c,0,EVENT_PLAY,nil,scard.op1,nil,scard.con1)
	e1:SetCountLimit(1)
end
scard.specified_cost={COLOR_YELLOW,1}
scard.combo_cost=0
--draw
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(aux.BattleAreaFilter(Card.IsControler),e:GetHandler(),tp)
	g:KeepAlive()
	e:SetLabelObject(g)
	return g:GetCount()>0
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	if not g:IsExists(aux.BattleAreaFilter(Card.IsCode,CARD_TOUGHENED_UP_KRILLIN),1,nil) then return end
	Duel.Draw(tp,1,REASON_EFFECT)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	--gain power
	aux.AddTempSkillUpdatePower(c,c,1,14000)
end
