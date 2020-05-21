--EX03-27 Forced Ejection Masked Saiyan
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_MASKED_SAIYAN)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_DARK_DEMON_REALM_SAGA)
	aux.AddCategory(c,NAME_CATEGORY_MASKED)
	--battle card
	aux.EnableBattleAttribute(c)
	--over realm
	aux.EnableOverRealm(c,3,aux.PaySkillCost(COLOR_COLORLESS,0,1))
	--warp
	local e1=aux.AddActivateMainSkill(c,0,scard.op1,nil,scard.tg1,EFFECT_FLAG_CARD_TARGET,scard.con1)
	e1:SetCountLimit(1)
end
scard.combo_cost=0
--warp
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.CheckCharge(tp) and Duel.GetEnergyCount(tp)<Duel.GetEnergyCount(1-tp)
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.EnergyAreaFilter(Card.IsAbleToWarp),0,LOCATION_ENERGY,1,1,HINTMSG_WARP)
scard.op1=aux.TargetCardsOperation(Duel.SendtoWarp,REASON_EFFECT)
