--TB1-033 Multi-Form Tien Shinhan
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_TIEN_SHINHAN)
	aux.AddSpecialTrait(c,TRAIT_EARTHLING,TRAIT_UNIVERSE_7)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,TRAIT_CATEGORY_UNIVERSE)
	--battle card
	aux.EnableBattleAttribute(c)
	--lose power
	aux.AddPermanentUpdatePower(c,scard.val1)
	--drop, search (play)
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,nil,scard.op1,EFFECT_FLAG_CARD_TARGET,aux.SelfLeaderCondition(Card.IsSpecialTrait,TRAIT_UNIVERSE_7))
end
scard.specified_cost={COLOR_BLUE,2}
scard.combo_cost=0
--lose power
function scard.val1(e,c)
	local tp=c:GetControler()
	local ct1=Duel.GetMatchingGroupCount(aux.BattleAreaFilter(Card.IsCharacter,CHARACTER_TIEN_SHINHAN),tp,LOCATION_BATTLE,0,nil)*-5000
	local ct2=Duel.GetMatchingGroupCount(aux.ComboAreaFilter(Card.IsCharacter,CHARACTER_TIEN_SHINHAN),tp,LOCATION_COMBO,0,nil)*-5000
	return ct1+ct2
end
--drop, search (play)
function scard.playfilter(c,e,tp)
	return c:IsCode(sid) and c:IsCanBePlayed(e,0,tp,false,false) and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DROP)
	local g1=Duel.SelectMatchingCard(tp,aux.HandFilter(Card.IsAbleToDrop),tp,LOCATION_HAND,0,0,1,nil)
	if g1:GetCount()==0 or Duel.SendtoDrop(g1,REASON_EFFECT)==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_PLAY)
	local g2=Duel.SelectMatchingCard(tp,scard.playfilter,tp,LOCATION_DECK,0,0,3,nil,e,tp)
	if g2:GetCount()==0 then return end
	Duel.SetTargetCard(g2)
	Duel.Play(g2,0,tp,tp,false,false,POS_FACEUP_ACTIVE)
end
