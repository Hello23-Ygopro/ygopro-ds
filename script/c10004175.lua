--EX03-21 Space Pirate Chilled
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_CHILLED)
	aux.AddSpecialTrait(c,TRAIT_FRIEZA_CLAN)
	aux.AddEra(c,ERA_CHILLED_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--drop, draw, token
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,nil,scard.op1,nil,aux.SelfLeaderCondition(Card.IsSpecialTrait,TRAIT_FRIEZA_CLAN))
end
--drop, draw, token
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendDecktoDropUpTo(tp,3,REASON_EFFECT)
	if not Duel.IsExistingMatchingCard(aux.DropAreaFilter(Card.IsSpecialTrait,TRAIT_FRIEZA_CLAN),tp,LOCATION_DROP,0,1,nil) then return end
	Duel.BreakEffect()
	Duel.Draw(tp,1,REASON_EFFECT)
	if not Duel.IsPlayerCanPlayToken(tp,CARD_EX0321_CHILLEDS_ARMY_TOKEN,0,TYPE_BATTLE,10000,COMBO_NONE,ENERGY_NONE,0,COLOR_NONE) then return end
	for i=1,2 do
		local token=Duel.CreateToken(tp,CARD_EX0321_CHILLEDS_ARMY_TOKEN-1+i)
		Duel.PlayStep(token,0,tp,tp,false,false,POS_FACEUP_ACTIVE)
	end
	Duel.PlayComplete()
end
