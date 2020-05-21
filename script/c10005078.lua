--BT5-065 Deadly Defender Android 18
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_ANDROID_18)
	aux.AddSpecialTrait(c,TRAIT_ANDROID)
	aux.AddEra(c,ERA_SUPER_17_SAGA)
	aux.AddCategory(c,NAME_CATEGORY_ANDROID)
	--battle card
	aux.EnableBattleAttribute(c)
	--barrier
	aux.EnableBarrier(c)
	--attack limit
	aux.AddPermanentCannotSelectBattleTarget(c,aux.TargetBoolFunction(Card.IsLeader),scard.con1,0,LOCATION_BATTLE)
	--lose power
	aux.AddPermanentUpdatePower(c,-5000,scard.con1)
end
scard.specified_cost={COLOR_GREEN,2}
scard.combo_cost=0
--attack limit, lose power
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return Duel.GetTurnPlayer()~=e:GetHandlerPlayer()
		and aux.SelfLeaderCondition(Card.IsColor,COLOR_GREEN)(e,tp,eg,ep,ev,re,r,rp) and c:IsFaceup() and c:IsRest()
end
