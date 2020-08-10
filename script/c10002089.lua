--BT2-079 Aura of Rage Super Saiyan Trunks
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,2)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_TRUNKS_FUTURE)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_ANDROID_CELL_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--ko
	aux.AddSingleAutoSkill(c,0,EVENT_CUSTOM+EVENT_COMBO,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
--ko
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp and not e:GetHandler():IsPreviousLocation(LOCATION_BATTLE)
end
function scard.kofilter(c)
	return c:IsHasEffect(EFFECT_BLOCKER) and c:IsEnergyBelow(3)
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(scard.kofilter),0,LOCATION_BATTLE,0,1,HINTMSG_KO)
scard.op1=aux.TargetCardsOperation(Duel.KO,REASON_EFFECT)
