--TB2-022 Scuffle Time Son Goten
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_SON_GOTEN_ADOLESCENCE)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_EARTHLING,TRAIT_WORLD_TOURNAMENT)
	aux.AddEra(c,ERA_MAJIN_BUU_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--untap, gain skill
	local e1=aux.AddActivateMainSkill(c,0,scard.op1,scard.cost1,scard.tg1,EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
end
scard.specified_cost={COLOR_BLUE,1}
scard.combo_cost=0
--untap, gain skill
scard.cost1=aux.SendtoHandCost(aux.LifeAreaFilter(nil),LOCATION_LIFE,0,1,1,true)
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	local c=e:GetHandler()
	if not Duel.IsExistingMatchingCard(aux.BattleAreaFilter(Card.IsCode,CARD_SCUFFLE_TIME_MR_BUU),tp,LOCATION_BATTLE,0,1,nil) then return end
	if c:IsCanBeEffectTarget(e) then Duel.SetTargetCard(c) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOACTIVE)
	Duel.SelectTarget(tp,aux.EnergyAreaFilter(Card.IsAbleToSwitchToActive),tp,LOCATION_ENERGY,0,0,1,nil)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if not g then return end
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	Duel.SwitchtoActive(sg,REASON_EFFECT)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	--gain power
	aux.AddTempSkillUpdatePower(c,c,1,10000)
end
