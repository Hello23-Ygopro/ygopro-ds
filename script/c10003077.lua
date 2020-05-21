--BT3-070 Dawn of Terror, Android 13
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_ANDROID_13)
	aux.AddSpecialTrait(c,TRAIT_ANDROID)
	aux.AddEra(c,ERA_ANDROID_13_SAGA)
	aux.AddCategory(c,NAME_CATEGORY_ANDROID)
	--battle card
	aux.EnableBattleAttribute(c)
	--union-absorb
	aux.EnableUnionAbsorb(c,scard.uniafilter,aux.MergeCost(aux.PaySkillCost(COLOR_GREEN,1,0),scard.cost1))
	--ko
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
scard.specified_cost={COLOR_GREEN,2}
scard.combo_cost=0
--union-absorb
function scard.uniafilter(c)
	return c:IsCharacter(CHARACTER_ANDROID_13) and c:IsEnergy(7)
end
function scard.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
	local f1=aux.DropAreaFilter(Card.IsCharacter,CHARACTER_ANDROID_14)
	local f2=aux.DropAreaFilter(Card.IsCharacter,CHARACTER_ANDROID_15)
	if chk==0 then return Duel.IsExistingTarget(f1,tp,LOCATION_DROP,0,1,nil)
		and Duel.IsExistingTarget(f2,tp,LOCATION_DROP,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ABSORB)
	local g1=Duel.SelectTarget(tp,f1,tp,LOCATION_DROP,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ABSORB)
	local g2=Duel.SelectTarget(tp,f2,tp,LOCATION_DROP,0,1,1,nil)
	g1:Merge(g2)
	Duel.PlaceUnder(e:GetHandler(),g1)
	Duel.ClearTargetCard()
end
--ko
scard.tg1=aux.TargetCardFunction(PLAYER_OPPO,aux.BattleAreaFilter(nil),0,LOCATION_BATTLE,1,1,HINTMSG_KO)
scard.op1=aux.TargetCardsOperation(Duel.KO,REASON_EFFECT)
