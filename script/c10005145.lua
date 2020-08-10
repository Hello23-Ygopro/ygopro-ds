--SD6-03 Fusion Reborn Son Goku
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_SON_GOKU)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_JANEMBA_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOKU)
	--battle card
	aux.EnableBattleAttribute(c)
	--draw
	aux.AddSingleAutoSkill(c,0,EVENT_DROP,nil,aux.DuelOperation(Duel.Draw,PLAYER_SELF,1,REASON_EFFECT),nil,scard.con1)
end
--draw
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_HAND)
		and re and re:IsHasCategory(CATEGORY_UNION_FUSION)
		and aux.SelfLeaderCondition(Card.IsCharacter,CHARACTER_GOGETA)(e,tp,eg,ep,ev,re,r,rp)
end
