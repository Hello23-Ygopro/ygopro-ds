--EX02-02 Masked Saiyan, the Mysterious Warrior
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_MASKED_SAIYAN)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_DARK_DEMON_REALM_SAGA)
	aux.AddCategory(c,NAME_CATEGORY_MASKED)
	--battle card
	aux.EnableBattleAttribute(c)
	--over realm
	aux.EnableOverRealm(c,5)
	--double strike
	aux.EnableDoubleStrike(c)
	--warp
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,aux.OverRealmPlayCondition)
end
scard.combo_cost=1
--warp
function scard.warpfilter(c)
	return not c:IsHasEffect(EFFECT_BLOCKER) and c:IsAbleToWarp()
end
scard.tg1=aux.TargetTotalCostBelowTarget(PLAYER_SELF,aux.BattleAreaFilter(scard.warpfilter),0,LOCATION_BATTLE,5,HINTMSG_WARP)
scard.op1=aux.TargetCardsOperation(Duel.SendtoWarp,REASON_EFFECT)
