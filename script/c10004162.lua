--EX03-10 Nightmare Scythe Goku Black
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,3)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_GOKU_BLACK)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_GOD)
	aux.AddEra(c,ERA_FUTURE_TRUNKS_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--barrier
	aux.EnableBarrier(c)
	--token
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,nil,scard.op1,nil,aux.SelfLeaderCondition(Card.IsCharacter,CHARACTER_ZAMASU,CHARACTER_GOKU_BLACK))
end
--token
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsPlayerCanPlayToken(tp,CARD_EX0310_SHADOW_TOKEN,0,TYPE_BATTLE,10000,5000,ENERGY_NONE,0,COLOR_NONE) then return end
	for i=1,2 do
		local token=Duel.CreateToken(tp,CARD_EX0310_SHADOW_TOKEN-1+i)
		Duel.PlayStep(token,0,tp,tp,false,false,POS_FACEUP_ACTIVE)
	end
	Duel.PlayComplete()
end
