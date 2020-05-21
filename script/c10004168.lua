--EX03-15 Vile Replication Cell
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_CELL)
	aux.AddSpecialTrait(c,TRAIT_ANDROID)
	aux.AddEra(c,ERA_ANDROID_CELL_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--draw, token
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,nil,scard.op1,nil,aux.SelfLeaderCondition(Card.IsSpecialTrait,TRAIT_ANDROID))
end
scard.specified_cost={COLOR_GREEN,2}
scard.combo_cost=0
--draw, token
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,2,REASON_EFFECT)
	if not Duel.IsPlayerCanPlayToken(tp,CARD_EX0315_CELL_JR_TOKEN,0,TYPE_BATTLE,10000,5000,ENERGY_NONE,0,COLOR_NONE) then return end
	for i=1,2 do
		local token=Duel.CreateToken(tp,CARD_EX0315_CELL_JR_TOKEN-1+i)
		Duel.PlayStep(token,0,tp,tp,false,false,POS_FACEUP_ACTIVE)
	end
	Duel.PlayComplete()
end
