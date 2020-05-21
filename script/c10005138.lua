--BT5-117 Dragon Ball
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--extra card
	aux.EnableExtraAttribute(c)
	--dragon ball
	aux.EnableDragonBall(c)
	--draw
	aux.AddActivateMainSkill(c,0,aux.DuelOperation(Duel.Draw,PLAYER_SELF,1,REASON_EFFECT),nil,nil,nil,aux.SelfLeaderCondition(Card.IsSpecialTrait,TRAIT_SHENRON))
end
