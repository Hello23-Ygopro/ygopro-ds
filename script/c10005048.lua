--BT5-041 North Kai, Keeping Watch
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_NORTH_KAI)
	aux.AddSpecialTrait(c,TRAIT_GOD)
	aux.AddEra(c,ERA_JANEMBA_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--super combo
	aux.EnableSuperCombo(c)
	--draw
	aux.AddSingleAutoSkill(c,0,EVENT_CUSTOM+EVENT_COMBO,nil,scard.op1,nil,scard.con1)
end
--draw
scard.con1=aux.AND(aux.SelfLeaderCondition(Card.IsColor,COLOR_BLUE),aux.LifeEqualBelowCondition(PLAYER_SELF,4))
scard.op1=aux.DuelOperation(Duel.Draw,PLAYER_SELF,1,REASON_EFFECT)
