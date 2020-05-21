--TB2-010 Secret Treaty Hercule
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_HERCULE)
	aux.AddSpecialTrait(c,TRAIT_EARTHLING,TRAIT_WORLD_TOURNAMENT)
	aux.AddEra(c,ERA_THE_EVIL_WIZARD_BABIDI_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--combo rest
	aux.AddSinglePermanentSkill(c,EFFECT_COMBO_REST_MODE,nil,LOCATION_BATTLE)
	--draw
	aux.AddActivateMainSkill(c,0,scard.op1,scard.cost1,nil,EFFECT_FLAG_CARD_TARGET)
end
scard.specified_cost={COLOR_RED,1}
scard.combo_cost=0
--draw
function scard.costfilter(c)
	return c:IsSpecialTrait(TRAIT_WORLD_TOURNAMENT) and c:IsAbleToSwitchToRest()
end
function scard.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local f=aux.BattleAreaFilter(scard.costfilter)
	if chk==0 then return c:IsAbleToSwitchToRest() and c:IsCanBeEffectTarget(e)
		and Duel.IsExistingTarget(f,tp,LOCATION_BATTLE,0,1,c) end
	local g1=Group.FromCards(c)
	Duel.SetTargetCard(g1)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOREST)
	local g2=Duel.SelectTarget(tp,f,tp,LOCATION_BATTLE,0,1,1,c)
	g1:Merge(g2)
	Duel.SwitchtoRest(g1,REASON_COST)
	Duel.ClearTargetCard()
end
scard.op1=aux.DuelOperation(Duel.Draw,PLAYER_SELF,1,REASON_EFFECT)
