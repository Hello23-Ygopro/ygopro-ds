--EX01-06 Unified Spirit Trunks
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_TRUNKS_YOUTH)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_MAJIN_BUU_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--return
	aux.AddActivateMainSkill(c,0,aux.SelfSendtoHandOperation,nil,aux.SelfSendtoHandTarget)
	--confirm, ko
	aux.AddSingleAutoSkill(c,1,EVENT_ATTACK_ANNOUNCE,nil,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--confirm, ko
function scard.conffilter(c)
	return c:IsCharacter(CHARACTER_SON_GOTEN) and not c:IsPublic()
end
function scard.kofilter(c,e)
	return c:IsEnergyBelow(3) and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local g1=Duel.SelectMatchingCard(tp,aux.HandFilter(scard.conffilter),tp,LOCATION_HAND,0,0,1,nil)
	if g1:GetCount()==0 then return end
	Duel.ConfirmCards(1-tp,g1)
	Duel.ShuffleHand(tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_KO)
	local g2=Duel.SelectMatchingCard(tp,aux.BattleAreaFilter(scard.kofilter),tp,0,LOCATION_BATTLE,0,1,nil,e)
	if g2:GetCount()==0 then return end
	Duel.SetTargetCard(g2)
	Duel.KO(g2,REASON_EFFECT)
end
