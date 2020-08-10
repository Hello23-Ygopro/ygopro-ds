--BT5-014 Scheming Oolong
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_RED,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_OOLONG)
	aux.AddSpecialTrait(c,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_PILAF_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--draw
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,nil,aux.DuelOperation(Duel.Draw,PLAYER_SELF,2,REASON_EFFECT),nil,scard.con1)
end
--draw
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return aux.SelfLeaderCondition(Card.IsSpecialTrait,TRAIT_SHENRON)(e,tp,eg,ep,ev,re,r,rp)
		and Duel.IsExistingMatchingCard(aux.DropAreaFilter(Card.IsCode,CARD_OOLONGS_WISH),tp,LOCATION_DROP,0,1,nil)
end
