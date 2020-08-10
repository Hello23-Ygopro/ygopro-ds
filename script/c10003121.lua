--BT3-109 SS3 Bardock, Power Unleashed
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_BARDOCK_XENO)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_DARK_DEMON_REALM_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--xeno-evolve
	aux.EnableXenoEvolve(c,aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_BARDOCK_XENO),aux.PaySkillCost(COLOR_COLORLESS,0,5))
	--triple strike
	aux.EnableTripleStrike(c)
	--drop, warp
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
--drop, warp
scard.con1=aux.AND(aux.EvolvePlayCondition,aux.SelfLeaderCondition(Card.IsColor,COLOR_BLACK))
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	if Duel.IsExistingTarget(Card.IsAbleToDrop,tp,LOCATION_WARP,0,5,nil) and Duel.SelectYesNo(tp,YESNOMSG_WARP) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DROP)
		Duel.SelectTarget(tp,Card.IsAbleToDrop,tp,LOCATION_WARP,0,5,5,nil)
	end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if not g1 then return end
	local sg=g1:Filter(Card.IsRelateToEffect,nil,e)
	if Duel.SendtoDrop(sg,REASON_EFFECT)==0 then return end
	local g2=Duel.GetMatchingGroup(aux.BattleAreaFilter(Card.IsAbleToWarp),tp,0,LOCATION_BATTLE,nil)
	Duel.SendtoWarp(g2,REASON_EFFECT)
end
