--BT2-014 Ghost Attack Super Saiyan 3 Gotenks
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_RED,3)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_GOTENKS)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_MAJIN_BUU_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--evolve
	aux.EnableEvolve(c,aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_GOTENKS),aux.PaySkillCost(COLOR_RED,2,2))
	--gain skill
	aux.EnableDoubleStrike(c,aux.HandEqualBelowCondition(PLAYER_SELF,4),LOCATION_BATTLE,0,scard.tg1)
	--token
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,nil,scard.op1)
end
--gain skill
function scard.tg1(e,c)
	return c==e:GetHandler() or c:IsCode(CARD_BT2014_GHOST_TOKEN)
end
--token
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsPlayerCanPlayToken(tp,CARD_BT2014_GHOST_TOKEN,0,TYPE_BATTLE,15000,COMBO_NONE,ENERGY_NONE,0,COLOR_NONE) then return end
	for i=1,3 do
		local token=Duel.CreateToken(tp,CARD_BT2014_GHOST_TOKEN-1+i)
		Duel.PlayStep(token,0,tp,tp,false,false,POS_FACEUP_ACTIVE)
	end
	Duel.PlayComplete()
end
