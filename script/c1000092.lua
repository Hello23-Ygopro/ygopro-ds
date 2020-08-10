--P-078 Demon Sword Janemba
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_JANEMBA)
	aux.AddSpecialTrait(c,TRAIT_EVIL_INCARNATE)
	aux.AddEra(c,ERA_JANEMBA_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--critical
	aux.EnableCritical(c)
	--deflect
	aux.EnableDeflect(c)
	--warp, drop
	aux.AddActivateMainSkill(c,0,scard.op1,scard.cost1,scard.tg1,EFFECT_FLAG_CARD_TARGET)
end
--warp, drop
scard.cost1=aux.SelfSendtoDeckCost(SEQ_DECK_BOTTOM)
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(Card.IsAbleToWarp),0,LOCATION_BATTLE,0,1,HINTMSG_WARP)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SendtoWarp(tc,REASON_EFFECT)
	end
	Duel.SendDecktoptoDrop(1-tp,2,REASON_EFFECT)
end
