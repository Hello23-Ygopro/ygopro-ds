--BT2-087 Uncountable Many Cell Jr.
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_CELL_JR)
	aux.AddSpecialTrait(c,TRAIT_ANDROID)
	aux.AddEra(c,ERA_ANDROID_CELL_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--token
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,nil,scard.op1,nil,aux.SelfLeaderCondition(Card.IsCharacter,CHARACTER_CELL))
end
--token
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsPlayerCanPlayToken(tp,CARD_BT2087_CELL_JR_TOKEN,0,TYPE_BATTLE,10000,5000,ENERGY_NONE,0,COLOR_NONE) then return end
	for i=1,2 do
		local token=Duel.CreateToken(tp,CARD_BT2087_CELL_JR_TOKEN)
		Duel.PlayStep(token,0,tp,tp,false,false,POS_FACEUP_ACTIVE)
	end
	Duel.PlayComplete()
end
