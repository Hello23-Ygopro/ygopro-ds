--BT4-117 Time Trauma Masked Saiyan
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_MASKED_SAIYAN)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_DARK_DEMON_REALM_SAGA)
	aux.AddCategory(c,NAME_CATEGORY_MASKED)
	--battle card
	aux.EnableBattleAttribute(c)
	--to hand, warp
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
--to hand, warp
scard.con1=aux.SelfLeaderCondition(Card.IsColor,COLOR_BLACK)
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.LifeAreaFilter(Card.IsAbleToHand),LOCATION_LIFE,0,0,2,HINTMSG_ATOHAND)
function scard.warpfilter(c,e)
	return c:IsEnergyBelow(5) and c:IsAbleToWarp() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if not g1 then return end
	local sg=g1:Filter(Card.IsRelateToEffect,nil,e)
	if Duel.SendtoHand(sg,PLAYER_OWNER,REASON_EFFECT)==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_WARP)
	local g2=Duel.SelectMatchingCard(tp,aux.BattleAreaFilter(scard.warpfilter),tp,0,LOCATION_BATTLE,0,1,nil,e)
	if g2:GetCount()==0 then return end
	Duel.BreakEffect()
	Duel.SetTargetCard(g2)
	Duel.SendtoWarp(g2,REASON_EFFECT)
end
