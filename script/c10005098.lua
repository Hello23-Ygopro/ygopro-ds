--BT5-082 Fired Up SS Son Gohan
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_SON_GOHAN_ADOLESCENCE)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_RESURRECTION_F_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOHAN)
	--battle card
	aux.EnableBattleAttribute(c)
	--barrier
	aux.EnableBarrier(c)
	--untap
	aux.AddAutoSkill(c,0,EVENT_PHASE+PHASE_END,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
--untap
function scard.untfilter(c)
	return c:IsColor(COLOR_YELLOW) and c:IsEnergyAbove(2) and c:IsAbleToSwitchToActive()
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
		and Duel.IsExistingTarget(aux.BattleAreaFilter(scard.untfilter),tp,LOCATION_BATTLE,0,1,e:GetHandler())
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOACTIVE)
	Duel.SelectTarget(tp,aux.BattleAreaFilter(scard.untfilter),tp,LOCATION_BATTLE,0,0,2,e:GetHandler())
end
scard.op1=aux.TargetCardsOperation(Duel.SwitchtoActive,REASON_EFFECT)
