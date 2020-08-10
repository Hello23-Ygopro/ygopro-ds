--BT1-078 Overflowing Bio Warrior Army
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_BIO_WARRIOR)
	aux.AddSpecialTrait(c,TRAIT_BIO_WARRIOR)
	aux.AddEra(c,ERA_BROLY_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--drop, play
	aux.AddSingleAutoSkill(c,0,EVENT_DROP,nil,scard.op1,nil,scard.con1)
end
--drop, play
scard.con1=aux.AND(aux.SelfLeaderCondition(Card.IsCharacter,CHARACTER_BROLY),aux.SelfPreviousLocationCondition(LOCATION_BATTLE))
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DROP)
	local g=Duel.SelectMatchingCard(tp,aux.HandFilter(Card.IsAbleToDrop),tp,LOCATION_HAND,0,0,1,nil)
	if g:GetCount()==0 or Duel.SendtoDrop(g,REASON_EFFECT)==0 then return end
	Duel.Play(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP_ACTIVE)
end
