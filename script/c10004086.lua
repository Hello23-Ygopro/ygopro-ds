--BT4-076 Abrupt Breakthrough Son Goku
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_SON_GOKU)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_UNIVERSE_7,TRAIT_GOKUS_LINEAGE)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOKU,TRAIT_CATEGORY_UNIVERSE)
	--battle card
	aux.EnableBattleAttribute(c)
	--swap
	aux.EnableSwap(c,8,aux.FilterBoolFunction(Card.IsSpecialTrait,TRAIT_GOKUS_LINEAGE),aux.PaySkillCost(COLOR_YELLOW,4,0))
	--barrier
	aux.EnableBarrier(c)
	--play
	local e1=aux.AddAutoSkill(c,0,EVENT_LEAVE_FIELD,nil,scard.op1,nil,scard.con1(scard.cfilter1))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_HAND)
	local e2=aux.AddAutoSkill(c,0,EVENT_CONTROL_CHANGED,nil,scard.op1,nil,scard.con1(scard.cfilter2))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetRange(LOCATION_HAND)
end
scard.specified_cost={COLOR_YELLOW,2}
scard.combo_cost=1
--play
function scard.cfilter1(c,tp)
	return c:IsPreviousPosition(POS_FACEUP) and c:IsSpecialTrait(TRAIT_GOKUS_LINEAGE) and c:GetPreviousEnergyInPlay()>=5
		and c:IsPreviousLocation(LOCATION_BATTLE) and c:GetPreviousControler()==tp
		and c:IsReason(REASON_EFFECT)
end
function scard.cfilter2(c,tp)
	return c:IsPreviousPosition(POS_FACEUP) and c:IsSpecialTrait(TRAIT_GOKUS_LINEAGE) and c:GetPreviousEnergyInPlay()>=5
		and c:IsPreviousLocation(LOCATION_BATTLE) and c:GetPreviousControler()==tp
end
function scard.con1(f)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				return eg:IsExists(f,1,nil,tp) and rp==1-tp
					and Duel.GetMatchingGroupCount(aux.BattleAreaFilter(nil),tp,LOCATION_BATTLE,0,nil)==0
			end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.GetMatchingGroupCount(aux.BattleAreaFilter(nil),tp,LOCATION_BATTLE,0,nil)==0 then
		Duel.Play(c,0,tp,tp,false,false,POS_FACEUP_ACTIVE)
	end
end
