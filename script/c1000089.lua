--P-075 Black Masked Saiyan, Splintering Mind
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_MASKED_SAIYAN)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_DARK_DEMON_REALM_SAGA)
	aux.AddCategory(c,NAME_CATEGORY_MASKED)
	--battle card
	aux.EnableBattleAttribute(c)
	--warp
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
	--sparking (warp)
	aux.EnableSparking(c)
	aux.AddSingleAutoSkill(c,1,EVENT_ATTACK_ANNOUNCE,scard.tg2,scard.op2,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
--warp
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(Card.IsAbleToWarp),0,LOCATION_BATTLE,0,1,HINTMSG_WARP)
scard.op1=aux.TargetCardsOperation(Duel.SendtoWarp,REASON_EFFECT)
--sparking (warp)
scard.con1=aux.AND(aux.SparkingCondition(7),aux.SelfLeaderCondition(Card.IsColor,COLOR_BLACK))
scard.tg2=aux.TargetCardFunction(PLAYER_SELF,aux.LifeAreaFilter(Card.IsAbleToWarp),LOCATION_LIFE,0,0,2,HINTMSG_WARP)
function scard.warpfilter(c,e)
	return c:IsAbleToWarp() and c:IsCanBeEffectTarget(e)
end
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if not g1 then return end
	local sg=g1:Filter(Card.IsRelateToEffect,nil,e)
	if Duel.SendtoWarp(sg,REASON_EFFECT)==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_WARP)
	local g2=Duel.SelectMatchingCard(tp,aux.LifeAreaFilter(scard.warpfilter),tp,0,LOCATION_LIFE,0,1,nil,e)
	if g2:GetCount()==0 then return end
	Duel.SetTargetCard(g2)
	Duel.SendtoWarp(g2,REASON_EFFECT)
end
