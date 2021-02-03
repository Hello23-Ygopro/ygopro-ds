--BT4-056 Popo, Guardian's Aide
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_POPO)
	aux.AddSpecialTrait(c,TRAIT_GOD)
	aux.AddEra(c,ERA_MAJIN_BUU_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--drop
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.op1,nil,scard.con1)
	aux.AddSingleAutoSkill(c,0,EVENT_CUSTOM+EVENT_COMBO,nil,scard.op1,nil,scard.con1)
end
--drop
scard.con1=aux.SelfLeaderCondition(Card.IsColor,COLOR_GREEN)
scard.op1=aux.DuelOperation(Duel.SendDecktoDropUpTo,PLAYER_SELF,3,REASON_EFFECT)
