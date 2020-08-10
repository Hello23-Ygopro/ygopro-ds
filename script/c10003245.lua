--TB1-083 Swift Warrior Dyspo
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,2)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_DYSPO)
	aux.AddSpecialTrait(c,TRAIT_ALIEN,TRAIT_PRIDE_TROOPERS,TRAIT_UNIVERSE_11)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,TRAIT_CATEGORY_UNIVERSE)
	--battle card
	aux.EnableBattleAttribute(c)
	--play
	aux.AddSingleAutoSkill(c,0,EVENT_CUSTOM+EVENT_COMBO_END,nil,aux.SelfPlayOperation(POS_FACEUP_REST),nil,scard.con1)
end
--play
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return aux.SelfLeaderCondition(Card.IsSpecialTrait,TRAIT_UNIVERSE_11)(e,tp,eg,ep,ev,re,r,rp)
		and not e:GetHandler():IsPreviousLocation(LOCATION_BATTLE)
end
