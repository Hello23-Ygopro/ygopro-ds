--BT2-033 Super Ghost Kamikaze Attack
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_RED,1)
	--extra card
	aux.EnableExtraAttribute(c)
	--token
	aux.AddActivateMainSkill(c,0,scard.op1,nil,nil,nil,aux.ExistingCardCondition(aux.FaceupFilter(Card.IsCharacter,CHARACTER_GOTENKS)))
end
--token
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsPlayerCanPlayToken(tp,CARD_BT2033_GHOST_TOKEN,0,TYPE_BATTLE,15000,COMBO_NONE,ENERGY_NONE,0,COLOR_NONE) then return end
	for i=1,2 do
		local token=Duel.CreateToken(tp,CARD_BT2033_GHOST_TOKEN-1+i)
		Duel.PlayStep(token,0,tp,tp,false,false,POS_FACEUP_ACTIVE)
	end
	Duel.PlayComplete()
end
