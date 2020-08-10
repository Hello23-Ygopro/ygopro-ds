--BT2-104 Destructive Occupation Frieza
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,2)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_FRIEZA)
	aux.AddSpecialTrait(c,TRAIT_FRIEZA_CLAN,TRAIT_FRIEZAS_ARMY)
	aux.AddEra(c,ERA_FRIEZA_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--play
	aux.AddSingleAutoSkill(c,0,EVENT_CUSTOM+EVENT_COMBO_END,nil,aux.SelfPlayOperation(POS_FACEUP_REST),nil,scard.con1)
end
--play
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return aux.SelfLeaderCondition(Card.IsColor,COLOR_YELLOW)(e,tp,eg,ep,ev,re,r,rp)
		and not e:GetHandler():IsPreviousLocation(LOCATION_BATTLE)
end
