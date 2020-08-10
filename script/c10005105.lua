--BT5-088 Full Surveillance Jaco
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_JACO)
	aux.AddSpecialTrait(c,TRAIT_GALACTIC_PATROL)
	aux.AddEra(c,ERA_RESURRECTION_F_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--super combo
	aux.EnableSuperCombo(c)
	--draw
	aux.AddSingleAutoSkill(c,0,EVENT_CUSTOM+EVENT_COMBO,nil,scard.op1,nil,scard.con1)
end
--draw
scard.con1=aux.AND(aux.SelfLeaderCondition(Card.IsColor,COLOR_YELLOW),aux.LifeEqualBelowCondition(PLAYER_SELF,4))
scard.op1=aux.DuelOperation(Duel.Draw,PLAYER_SELF,1,REASON_EFFECT)
