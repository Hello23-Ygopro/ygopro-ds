--BT4-074 Gine, Here to Support
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_GINE)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_GOKUS_LINEAGE)
	aux.AddEra(c,ERA_BARDOCK_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--drop
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.op1,nil,scard.con1)
	aux.AddSingleAutoSkill(c,0,EVENT_CUSTOM+EVENT_COMBO,nil,scard.op1,nil,scard.con1)
end
--drop
scard.con1=aux.SelfLeaderCondition(Card.IsColor,COLOR_YELLOW)
scard.op1=aux.DuelOperation(Duel.SendDecktoptoDropUpTo,PLAYER_SELF,3,REASON_EFFECT)
